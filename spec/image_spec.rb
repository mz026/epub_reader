require 'spec_helper'

describe EpubReader::Image do
  subject { EpubReader::Image }
  let(:fixture_path) do
    Pathname.new(File.expand_path(__FILE__)).join('..', 'fixtures')
  end
  let(:path) { fixture_path.join('epub20_unzipped', 'EPUB', 'wasteland-cover.jpg') }

  describe '::new(path)' do
    it 'takes a path to init' do
      image = subject.new(path)
    end

    it 'raises if path not eixsts' do
      path = Pathname.new('non-exists')
      expect {
        image = subject.new(path)
      }.to raise_error(EpubReader::Image::PathNotExistsException)
    end
  end

  describe '#path' do
    it 'returns the path' do
      image = subject.new(path)
      
      image.path.should == path
    end
  end
end
