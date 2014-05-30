require 'spec_helper'

describe EpubReader::TOCItem do
  subject { EpubReader::TOCItem }

  describe '::new(:title => title, :html_path => html_path)' do
    it 'takes an title and html path to init' do
      subject.new(:title => 'the-title', :html_path => Pathname.new('html-path'))
    end
  end

  describe '#html_path' do
    let(:html_path) { Pathname.new('html-path') }

    it 'returns html_path given' do
      toc_item = subject.new(:title => 'the-title', :html_path => html_path)
      toc_item.html_path.should == html_path
    end
  end

  describe '#title' do
    it 'returns title passed in' do
      toc_item = subject.new(:title => 'the-title', :html_path => 'whatever')

      toc_item.title.should == 'the-title'
    end
  end

  describe 'create_from(unzipped_path)' do
    subject { EpubReader::TOCItem }
    let(:unzipped_path) do
      current_path = File.expand_path(File.dirname(__FILE__)) 
      Pathname.new(current_path).join('fixtures', 'epub20_unzipped')
    end
    let(:ncx_path) do
      ncx = Dir["#{unzipped_path}/**/*.ncx"].first
      ncx_dirname = File.expand_path(File.dirname(ncx))
      Pathname.new(ncx_dirname)
    end

    it 'raises if dir not exists' do
      expect {
        subject.create_from('non-exists')
      }.to raise_error(EpubReader::DirectoryNotExistsException)
    end

    it 'returns items in toc.ncx' do
      toc_items = subject.create_from(unzipped_path)
      expected = [
        {
          :title => "I. THE BURIAL OF THE DEAD",
          :html_path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "II. A GAME OF CHESS",
          :html_path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "III. THE FIRE SERMON",
          :html_path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "IV. DEATH BY WATER",
          :html_path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "V. WHAT THE THUNDER SAID",
          :html_path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => 'NOTES ON "THE WASTE LAND"',
          :html_path => ncx_path.join("wasteland-content.xhtml")
        },
      ]

      toc_items.map do |i|
        { :title => i.title, :html_path => i.html_path }
      end.should == expected
    end
  end
end
