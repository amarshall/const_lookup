require 'const_lookup/version'

class ConstLookup
  def self.lookup name, namespace = Object
    new(namespace).lookup(name)
  end

  def initialize namespace
    raise ArgumentError, 'namespace must be a Module' unless namespace.is_a? Module
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
    end.map do |name|
      namespaced_const_get name
    end.reverse
  end

  private

  def namespaced_const_get name
    name.split('::').reduce(Object) do |constant, part|
      constant.const_get part
    end
  end
end
