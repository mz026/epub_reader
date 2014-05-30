class EpubReader::Entry
  class EntryException < Exception; end
  class PathNotExistsException < EntryException; end

  def initialize toc_item
    unless File.exists?(toc_item.path)
      raise PathNotExistsException, "file #{toc_item.path} not exists" 
    end


  end
end
