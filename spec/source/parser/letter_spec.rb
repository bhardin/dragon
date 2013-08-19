require "spec_helper"

describe Dragon::Parser::Letter do
  let(:parser) do
    class ExampleParser < Parslet::Parser
      include Dragon::Parser::Letter
    end.new
  end

  describe "#upper_letter" do
    it "parses A" do
      expect(parse(:upper_letter, "A")).to eq("A")
    end

    it "parses M" do
      expect(parse(:upper_letter, "M")).to eq("M")
    end

    it "parses Z" do
      expect(parse(:upper_letter, "Z")).to eq("Z")
    end
  end

  describe "#lower_letter" do
    it "parses a" do
      expect(parse(:lower_letter, "a")).to eq("a")
    end

    it "parses m" do
      expect(parse(:lower_letter, "m")).to eq("m")
    end

    it "parses z" do
      expect(parse(:lower_letter, "z")).to eq("z")
    end
  end
end
