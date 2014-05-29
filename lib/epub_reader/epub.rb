require 'pathname'

class EpubReader::Epub
  class EpubReaderException < Exception; end
  class FileNotExistsException < EpubReaderException; end

  def initialize epub_path
    raise FileNotExistsException unless File.exists?(epub_path)
    @working_dir = "/tmp/#{SecureRandom.hex(5)}"

    Kernel.system("mkdir #{@working_dir}")
    Kernel.system("cp #{epub_path} #{@working_dir}")

    EpubReader::TOCItem.create_from(@working_dir).map do |toc_item|
      EpubReader::Entry.new(toc_item)
    end
  end
end