require "spec_helper"

describe Dragon::Parser::Whitespace do
  let(:parser) do
    class ExampleParser < Parslet::Parser
      include Dragon::Parser::Whitespace
    end.new
  end

  describe "#space" do
    it "parses space" do
      expect(parse(:space, "\s")).to eq("\s")
    end

    it "parses tab" do
      expect(parse(:space, "\t")).to eq("\t")
    end
  end

  describe "#newline" do
    it "parses windows return" do
      expect(parse(:newline, "\r")).to eq("\r")
    end

    it "parses unix return" do
      expect(parse(:newline, "\n")).to eq("\n")
    end
  end

  describe "#white_space" do
    it "parses single spaces" do
      expect(parse(:white_space, "\s")).to eq("\s")
    end

    it "parses multiple spaces" do
      expect(parse(:white_space, "\s\s")).to eq("\s\s")
    end

    it "parses single tabs" do
      expect(parse(:white_space, "\t")).to eq("\t")
    end

    it "parses multiple spaces" do
      expect(parse(:white_space, "\t\t")).to eq("\t\t")
    end

    it "parses mixed spaces" do
      expect(parse(:white_space, "\s\t")).to eq("\s\t")
    end
  end
end
