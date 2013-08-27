require 'const_lookup'
require 'const_lookup/core_ext'

describe "README examples" do
  describe "example 1" do
    before do
      module A
        module B; end
        module C; end
      end
      module D; end
    end

    after do
      Object.send :remove_const, :A
      Object.send :remove_const, :D
    end

    it "works" do
      expect(ConstLookup.lookup('A', A::C)).to eq A
      expect(ConstLookup.lookup('B', A::C)).to eq A::B
      expect(ConstLookup.lookup('D', A::C)).to eq D
      expect{ConstLookup.lookup('E', A::C)}.to raise_error NameError, %q(Failed to find `E' in A::C)
    end
  end

  describe "example 2" do
    before do
      module A
        module B; end
        module C; end
      end
      module D; end
    end

    after do
      Object.send :remove_const, :A
      Object.send :remove_const, :D
    end

    it "works" do
      expect(A::C.const_lookup('B')).to eq A::B
      expect(A::C.const_lookup('D')).to eq D
    end
  end

  describe "example 3" do
    before do
      module A
        module B; end
        module C; end
      end
      module D; end
    end

    after do
      Object.send :remove_const, :A
      Object.send :remove_const, :D
    end

    it "works" do
      expect(A::C.const_get('A')).to eq A
      expect{A::C.const_get('B')}.to raise_error NameError, %q(uninitialized constant A::C::B)
      expect(A::C.const_get('D')).to eq D
      expect{A::C.const_get('E')}.to raise_error NameError, %q(uninitialized constant A::C::E)
    end
  end
end
