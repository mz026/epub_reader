require 'spec_helper'

describe EpubReader::Entry do
  subject { EpubReader::Entry }
  let(:title) { 'the-entry-title' }
  let(:fixture_path) do
    Pathname.new(File.expand_path(__FILE__)).join('..', 'fixtures')
  end

  let(:toc_item) do 
    path = fixture_path.join('epub20_unzipped', 
                             'EPUB', 
                             'wasteland-content.xhtml')
    double(:title => title, :path => path)
  end

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
    pending
  end

  describe '#html_text' do
    pending
  end

  describe '#images' do
    pending
  end
end
