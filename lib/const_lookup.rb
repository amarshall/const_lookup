require 'const_lookup/version'

class ConstLookup
  def self.lookup name, namespace = nil
    new(*namespace).lookup(name)
  end

  def initialize namespace = Object
    @namespace = namespace.to_s
  end

  def lookup name
    name = name.to_sym
    constant = lookup_path.select do |namespace|
      namespace.const_defined? name
    end.map do |namespace|
      namespace.const_get name
    end.sort_by do |constant|
      -constant.to_s.split('::').size
    end.first
    constant or raise NameError, "Failed to find `#{name}' in #@namespace"
  end

  def lookup_path
    @namespace.split('::').reduce([]) do |lookup_path, part|
      lookup_path << [*lookup_path.last, part]
    end.map do |parts|
      parts.join '::'
    end.map do |constant_name|
      Object.const_get constant_name
    end.reverse
  end
end
