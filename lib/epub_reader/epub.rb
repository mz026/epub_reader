require 'pathname'

class EpubReader::Epub
  class EpubReaderException < Exception; end
  class FileNotExistsException < EpubReaderException; end

  attr_reader :entries
  def initialize epub_path
    raise FileNotExistsException unless File.exists?(epub_path)
    @working_dir = "/tmp/#{SecureRandom.hex(5)}"

    Kernel.system("mkdir #{@working_dir}")
    Kernel.system("cp #{epub_path} #{@working_dir}")
    Kernel.system("cd #{@working_dir} && unzip *.epub")

    @entries = EpubReader::TOCItem.create_from(@working_dir).map do |toc_item|
      EpubReader::Entry.new(toc_item)
    end
  end
end
