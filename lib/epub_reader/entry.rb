require 'nokogiri'
class EpubReader::Entry
  attr_reader :title
  def initialize toc_item
    unless File.exists?(toc_item.html_path)
      raise EpubReader::FileNotExistsException, "file #{toc_item.html_path} not exists" 
    end

    @title = toc_item.title
    @html_path = toc_item.html_path
  end

  def html_text
    @html_text ||= File.read(@html_path)
  end

  def images
    doc = Nokogiri.XML(html_text)
    doc.root.xpath('//xmlns:img').map do |image_element|
      EpubReader::Image.new(@html_path.join('..', image_element['src']))
    end
  end
end
