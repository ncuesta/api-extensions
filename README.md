# api-extensions [![Build Status](https://travis-ci.org/ncuesta/api-extensions.png)](https://travis-ci.org/ncuesta/api-extensions) [![Dependency Status](https://gemnasium.com/ncuesta/api-extensions.png)](https://gemnasium.com/ncuesta/api-extensions) [![Code Climate](https://codeclimate.com/github/ncuesta/api-extensions.png)](https://codeclimate.com/github/ncuesta/api-extensions)

A collection of extensions for Hypermedia-driven APIs following the standard definitions
at [the api-doc repo](https://github.com/ncuesta/api-doc).

Included extensions:

- `fields`

## Installation

Add this line to your application's Gemfile:

    gem 'api-extensions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api-extensions

## Usage

### `fields` extension

The behavior of this extension is best described at
[the api-doc repo](https://github.com/ncuesta/api-doc/blob/master/README.en.md#partial-responses).

By including the `Api::Extensions::Fields` module in any class, you will get a `process_fields`
method that will handle the creation of partial responses - as described in the linked document.

```ruby
require 'api/extensions/fields'

class MyApiHandler
  include Api::Extensions::Fields

  def handle(request)
    response = fiddle_with request
    process_fields request[:fields], response, request.path
  end
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
