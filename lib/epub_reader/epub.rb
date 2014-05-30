require 'pathname'

class EpubReader::Epub
  attr_reader :entries
  def initialize epub_path
    raise EpubReader::FileNotExistsException, "epub file #{epub_path} not exists" unless File.exists?(epub_path)
    @working_dir = "/tmp/#{SecureRandom.hex(5)}"

    Kernel.system("mkdir #{@working_dir}")
    Kernel.system("cp #{epub_path} #{@working_dir}")
    Kernel.system("cd #{@working_dir} && unzip *.epub")

    @entries = EpubReader::TOCItem.create_from(@working_dir).map do |toc_item|
      EpubReader::Entry.new(toc_item)
    end
  end
end
