# ConstLookup

[![Gem Version](https://img.shields.io/gem/v/const_lookup.svg?style=flat)](https://rubygems.org/gems/const_lookup)
[![Build Status](https://secure.travis-ci.org/amarshall/const_lookup.svg?branch=master)](https://travis-ci.org/amarshall/const_lookup)
[![Code Climate rating](https://codeclimate.com/github/amarshall/const_lookup.svg)](https://codeclimate.com/github/amarshall/const_lookup)

Makes resolving a constant in a given namespace easy.

## Installation

Install as usual: `gem install const_lookup` or add `gem 'const_lookup'` to your Gemfile. See `.travis.yml` for supported (tested) Ruby versions.

## Usage

```ruby
module A
  module B; end
  module C; end
end
module D; end

require 'const_lookup'

ConstLookup.lookup('A', A::C)  #=> A
ConstLookup.lookup('B', A::C)  #=> A::B
ConstLookup.lookup('D', A::C)  #=> D
ConstLookup.lookup('E', A::C)  #=> #<NameError: Failed to find `E' in A::C>
```

Or, if you like monkey-patching Ruby core:

```ruby
module A
  module B; end
  module C; end
end
module D; end

require 'const_lookup/core_ext'

A::C.const_lookup('B')  #=> A::B
A::C.const_lookup('D')  #=> D
```

Compare this with using [`Module#const_get`](http://ruby-doc.org/core/Module.html#method-i-const_get):

```ruby
module A
  module B; end
  module C; end
end
module D; end

A::C.const_get('A')  #=> A
A::C.const_get('B')  #=> #<NameError: uninitialized constant A::C::B>
A::C.const_get('D')  #=> D
A::C.const_get('E')  #=> #<NameError: uninitialized constant A::C::E>
```

This is because `const_get` looks up the *ancestor tree*, not the namespace tree like `ConstLookup` does.

## Contributing

Contributions are welcome. Please be sure that your pull requests are atomic so they can be considered and accepted separately.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits & License

Copyright © 2013–2017 J. Andrew Marshall. License is available in the LICENSE file.
