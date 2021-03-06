# api-extensions [![Build Status](https://travis-ci.org/ncuesta/api-extensions.png)](https://travis-ci.org/ncuesta/api-extensions) [![Dependency Status](https://gemnasium.com/ncuesta/api-extensions.png)](https://gemnasium.com/ncuesta/api-extensions) [![Code Climate](https://codeclimate.com/github/ncuesta/api-extensions.png)](https://codeclimate.com/github/ncuesta/api-extensions)

A collection of extensions for Hypermedia-driven APIs following the standard definitions
at [the api-doc repo](https://github.com/ncuesta/api-doc).

Included extensions:

- `fields`
- `expand`

## Installation

Add this line to your application's Gemfile:

    gem 'api-extensions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api-extensions

## Usage

### Including all extensions

As a more convenient way of including **all** the extensions, you may just include the module
`Api::Extensions::All` in your class and you will automatically have included all of the extensions
listed below.

```ruby
require 'api/extensions/expand'

class MyApiHandler
  include Api::Extensions::All

  expand_with :my_resource_fetching_method
end
```

### `expand` extension

The behavior of this extension is best described at
[the api-doc repo](https://github.com/ncuesta/api-doc/blob/master/README.en.md#links-expansion).

By including the `Api::Extensions::Expand` module in any class, you will get a `process_expand`
method that will handle the expansion of linked resources - as described in the linked document.

Please note that this extension **requires that the including class responds to a `get` method**.

```ruby
require 'api/extensions/expand'

class MyApiHandler
  include Api::Extensions::Expand

  expand_with :go_fetch

  def go_fetch(url)
    # Go fetch the resource at the given URL and return it
  end

  def handle(request)
    response = fiddle_with request
    process_expand request[:expand], response
  end
end
```

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

## Running tests

The test suite uses Cucumber, and can be run through `rake`:

```bash
$ rake features
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

### v0.0.3

* Switched `expand` to some metaprogramming: made the fetch method configurable (was hardcoded to `get`)
* Added a *meta module* `All` for including all API extensions in a single sentence

### v0.0.2

* Added `expand` extension

### v0.0.1

* Initial version
* Included `fields` extension