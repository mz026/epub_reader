require 'spec_helper'

describe EpubReader::TOCItem do
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
          :path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "II. A GAME OF CHESS",
          :path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "III. THE FIRE SERMON",
          :path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "IV. DEATH BY WATER",
          :path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => "V. WHAT THE THUNDER SAID",
          :path => ncx_path.join("wasteland-content.xhtml")
        },
        {
          :title => 'NOTES ON "THE WASTE LAND"',
          :path => ncx_path.join("wasteland-content.xhtml")
        },
      ]

      toc_items.map do |i|
        { :title => i.title, :path => i.path }
      end.should == expected
    end
  end
end
