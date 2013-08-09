require 'const_lookup/core_ext'

describe "core extensions" do
  describe Module do
    describe ".const_lookup" do
      it "calls ConstLookup.lookup with the receiving Module" do
        tofind = double
        mod = Module.new
        expect(ConstLookup).to receive(:lookup).with(tofind, mod)
        mod.const_lookup tofind
      end

      it "calls ConstLookup.lookup with the receiving Class" do
        tofind = double
        klass = Class.new
        expect(ConstLookup).to receive(:lookup).with(tofind, klass)
        klass.const_lookup tofind
      end
    end
  end
end
