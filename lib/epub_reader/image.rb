class EpubReader::Image
  class ImageException < Exception; end
  class PathNotExistsException < ImageException; end

  attr_reader :path
  def initialize path
    raise PathNotExistsException, "image file #{path} not exists" unless File.exists?(path)
    @path = path
  end
end
