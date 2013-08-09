require 'const_lookup'

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
end
