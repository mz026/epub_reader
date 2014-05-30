module EpubReader
  class EpubReaderException < Exception; end
  class FileNotExistsException < EpubReaderException; end
  class DirectoryNotExistsException < EpubReaderException; end
end
