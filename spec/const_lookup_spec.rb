require 'const_lookup'

describe ConstLookup do
  describe ".lookup" do
    it "creates a new finder with the given namespace and calls lookup with the name" do
      name = double
      namespace = double
      finder = double
      expect(ConstLookup).to receive(:new).with(namespace).and_return finder
      expect(finder).to receive(:lookup).with(name)

      ConstLookup.lookup name, namespace
    end

    it "creates the new finder with no args when no namespace given" do
      name = double
      finder = double
      expect(ConstLookup).to receive(:new).with(no_args).and_return finder
      expect(finder).to receive(:lookup).with(name)

      ConstLookup.lookup name
    end
  end

  describe "#lookup" do
    it "returns the constant when it resides in the most specific namespace" do
      stub_const('Foo::Bar::Baz', Module.new)
      stub_const('Foo::Bar::Baz::ToFind', Module.new)
      constant_finder = ConstLookup.new(Foo::Bar::Baz)
      expect(constant_finder.lookup(:ToFind)).to eq Foo::Bar::Baz::ToFind
    end

    it "returns the constant when it's a sibling" do
      stub_const('Foo::Bar::ToFind', Module.new)
      stub_const('Foo::Bar::Baz', Module.new)
      constant_finder = ConstLookup.new(Foo::Bar::Baz)
      expect(constant_finder.lookup(:ToFind)).to eq Foo::Bar::ToFind
    end

    it "returns the constant when it resides in an intermediate namespace" do
      stub_const('Foo::ToFind', Module.new)
      stub_const('Foo::Bar::Baz', Module.new)
      constant_finder = ConstLookup.new(Foo::Bar::Baz)
      expect(constant_finder.lookup(:ToFind)).to eq Foo::ToFind
    end

    it "returns the constant when it resides in global namespace" do
      stub_const('ToFind', Module.new)
      stub_const('Foo::Bar::Baz', Module.new)
      constant_finder = ConstLookup.new(Foo::Bar::Baz)
      expect(constant_finder.lookup(:ToFind)).to eq ToFind
    end

    it "returns the constant in the most specific namespace when it exists in multiple parts of the lookup path" do
      stub_const('ToFind', Module.new)
      stub_const('Foo::ToFind', Module.new)
      stub_const('Foo::Bar::ToFind', Module.new)
      stub_const('Foo::Bar::Baz', Module.new)
      constant_finder = ConstLookup.new(Foo::Bar::Baz)
      expect(constant_finder.lookup(:ToFind)).to eq Foo::Bar::ToFind
    end

    it "raises a NameError when the constant does not exist" do
      stub_const('Other::ToFind', Module.new)
      stub_const('Foo::Bar::Baz', Module.new)
      constant_finder = ConstLookup.new(Foo::Bar::Baz)
      expect do
        constant_finder.lookup(:ToFind)
      end.to raise_error NameError, %q(Failed to find `ToFind' in Foo::Bar::Baz)
    end
  end

  describe "#lookup_path" do
    it "is just Object when no namespace is given" do
      constant_finder = ConstLookup.new
      expect(constant_finder.lookup_path).to eq [Object]
    end

    it "is a list of each constant in the namespace in ascending order" do
      stub_const('Foo::Bar::Baz', Module.new)
      constant_finder = ConstLookup.new(Foo::Bar::Baz)
      expect(constant_finder.lookup_path).to eq [Foo::Bar::Baz, Foo::Bar, Foo]
    end
  end
end
