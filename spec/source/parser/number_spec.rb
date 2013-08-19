require "spec_helper"

describe Dragon::Parser::Number do
  let(:parser) do
    class ExampleParser < Parslet::Parser
      include Dragon::Parser::Number
    end.new
  end

  describe "#decimal" do
    it "parses 1.0" do
      expect(parse(:decimal, "1.0")).to eq("1.0")
    end

    it "parses 10.005" do
      expect(parse(:decimal, "10.005")).to eq("10.005")
    end

    it "parses 0.5" do
      expect(parse(:decimal, "0.5")).to eq("0.5")
    end

    it "parses 0.5555" do
      expect(parse(:decimal, "0.5555")).to eq("0.5555")
    end
  end

  describe "#integer" do
    it "parses 1" do
      expect(parse(:integer, "1")).to eq("1")
    end

    it "parses 5" do
      expect(parse(:integer, "5")).to eq("5")
    end

    it "parses 9" do
      expect(parse(:integer, "9")).to eq("9")
    end
  end

  describe "#negative" do
    it "parses -1" do
      expect(parse(:negative, "-1")).to eq("-1")
    end

    it "parses -55" do
      expect(parse(:negative, "-55")).to eq("-55")
    end

    it "parses -1.0" do
      expect(parse(:negative, "-1.0")).to eq("-1.0")
    end

    it "parses -1.55" do
      expect(parse(:negative, "-1.55")).to eq("-1.55")
    end
  end
end
