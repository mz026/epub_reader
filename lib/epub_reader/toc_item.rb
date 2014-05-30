require 'nokogiri'
class EpubReader::TOCItem
  class << self
    def create_from unzipped_path
      unless Dir.exists?(unzipped_path)
        raise EpubReader::DirectoryNotExistsException, "unzipped directory #{unzipped_path} not exists" 
      end

      ncx_path = Dir["#{unzipped_path}/**/*.ncx"].first
      ncx_dir = Pathname.new(File.expand_path(File.dirname(ncx_path)))
      
      root = Nokogiri.XML(File.open(ncx_path)).root

      nav_points = root.xpath('//xmlns:navPoint').map do |n|
        relative_path = n.xpath('.//xmlns:content').first['src'].gsub(/#.*$/, '')

        new({
          :title => n.xpath('.//xmlns:text').text,
          :path => ncx_dir.join(relative_path)
        })
      end
    end

  end


  attr_reader :title, :path
  def initialize options
    @title = options[:title]
    @path = options[:path]
  end
end
