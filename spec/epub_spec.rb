require 'spec_helper'

describe EpubReader::Epub do
  let(:spec_path) { Pathname.new(File.expand_path(File.dirname(__FILE__))) }
  let(:epub_path) { spec_path.join('fixtures/epub20.epub') }
  let(:random_hex) { 'random-hex' }
  let(:toc_item) { double(:toc_item) }
  let(:entry) { double(:entry) }

  before :each do
    SecureRandom.stub(:hex => random_hex)
    Kernel.stub(:system => true)
    EpubReader::TOCItem.stub(:create_from => [ toc_item ])
    EpubReader::Entry.stub(:new => entry)
  end

  describe '::new(epub_file_path)' do

    it 'takes a file path to create' do
      EpubReader::Epub.new(epub_path)
    end

    it 'raises if file not exists' do
      expect {
        EpubReader::Epub.new('non-exists')
      }.to raise_error(EpubReader::FileNotExistsException)
    end

    it 'unzip the epub at random folder in /tmp' do
      Kernel.should_receive(:system).with("mkdir /tmp/#{random_hex}")
      Kernel.should_receive(:system).with("cp #{epub_path} /tmp/#{random_hex}")
      Kernel.should_receive(:system).with("cd /tmp/#{random_hex} && unzip *.epub")

      EpubReader::Epub.new(epub_path)
    end

    it 'creates Entries according to the result of TOCItem::create_from' do
      EpubReader::TOCItem.should_receive(:create_from).with("/tmp/#{random_hex}")
      EpubReader::Entry.should_receive(:new).with(toc_item)

      EpubReader::Epub.new(epub_path)
    end
  end

  describe '#entries' do
    it 'returns entries created' do
      epub = EpubReader::Epub.new(epub_path)
      epub.entries.should == [ entry ]
    end
  end
end
