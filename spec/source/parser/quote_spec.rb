require "spec_helper"

describe Dragon::Parser::Quote do
  let(:parser) do
    class ExampleParser < Parslet::Parser
      include Dragon::Parser::Quote
    end.new
  end

  describe "#single_quoted" do
    it "parses 'Foo'" do
      expect(parse(:single_quoted, "'Foo'")).to eq("'Foo'")
    end
  end

  describe "#double_quoted" do
    it "parses \"Foo\"" do
      expect(parse(:double_quoted, "\"Foo\"")).to eq("\"Foo\"")
    end
  end
end
