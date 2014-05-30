require 'spec_helper'

describe EpubReader::Entry do
  subject { EpubReader::Entry }
  let(:title) { 'the-entry-title' }
  let(:fixture_path) do
    Pathname.new(File.expand_path(__FILE__)).join('..', 'fixtures')
  end
  let(:html_path) do
    fixture_path.join('epub20_unzipped', 
                      'EPUB', 
                      'wasteland-content.xhtml')
  end

  let(:toc_item) { double(:title => title, :path => html_path) }

  describe '::new(toc_item)' do
    it 'takes a toc item to init' do
      entry = subject.new(toc_item)
    end

    it 'raises if `toc_item` path not exists' do
      toc_item.stub(:path => Pathname.new('non-exists'))
      expect {
        entry = subject.new(toc_item)
      }.to raise_error(EpubReader::Entry::PathNotExistsException)
    end
  end

  describe '#title' do
    it 'forwards the title of toc_item' do
      entry = subject.new(toc_item)

      entry.title.should == toc_item.title
    end
  end

  describe '#html_text' do
    it 'returns the contents of html file' do
      entry = subject.new(toc_item)

      entry.html_text.should == File.read(html_path)
    end
  end

  describe '#images' do
    let(:image) { double(:image) }
    before :each do
      EpubReader::Image.stub(:new => image)
    end

    it 'returns the images within the html' do
      entry = subject.new(toc_item)
      EpubReader::Image.should_receive(:new)
                       .with(html_path.join('..', 'wasteland-cover.jpg'))

      entry.images.should == [ image ]
    end
  end
end
