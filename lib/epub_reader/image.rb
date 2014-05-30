class EpubReader::Image
  attr_reader :path
  def initialize path
    raise EpubReader::FileNotExistsException, "image file #{path} not exists" unless File.exists?(path)
    @path = path
  end
end
