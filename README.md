# EpubReader

EpubReader is a gem to parse epub file, including it's htmls and images

## Installation

Add this line to your application's Gemfile:

    gem 'epub_reader'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install epub_reader

## Usage

        epub = EpubReader::Epub.new('/the/epub/path.epub')
        epub.entries.each do |entry|
          entry.html_text #=> html text
          entry.title #=> entry title
          entry.images.each do |image|
            image.path #=> image file path
          end
        end


## API Documentation:

### `EpubReader::Epub`

- `::new(epub_file_path)`: returns an epub instance
- `#entries`: returns an array of `EpubReader::Entry`

### `EpubReader::Entry`

- `#title`: returns entry title
- `#html_text`: returns html text of the entry
- `#imags`: returns array of `EpubReader::Image`


### `EpubReader::Image`

- `#path`: returns the file path of the image


## Tests:

        $ rake test

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
