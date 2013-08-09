# ConstLookup

Makes resolving a constant in a given namespace easy.

## Installation

Install as usual: `gem install const_lookup` or add `gem 'const_lookup'` to your Gemfile. Note that Ruby 2.0 is required.

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

## Contributing

Contributions are welcome. Please be sure that your pull requests are atomic so they can be considered and accepted separately.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits & License

Copyright © 2013 J. Andrew Marshall. License is available in the LICENSE file.