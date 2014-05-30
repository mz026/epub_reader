require 'nokogiri'
class EpubReader::Entry
  attr_reader :title
  def initialize toc_item
    unless File.exists?(toc_item.path)
      raise EpubReader::FileNotExistsException, "file #{toc_item.path} not exists" 
    end

    @title = toc_item.title
    @path = toc_item.path
  end

  def html_text
    @html_text ||= File.read(@path)
  end

  def images
    doc = Nokogiri.XML(html_text)
    doc.root.xpath('//xmlns:img').map do |image_element|
      EpubReader::Image.new(@path.join('..', image_element['src']))
    end
  end
end
