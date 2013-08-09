require 'const_lookup'

class ConstLookup
  module CoreExt
    def const_lookup name
      ConstLookup.lookup name, self
    end
  end
end

class Module
  include ConstLookup::CoreExt
end
