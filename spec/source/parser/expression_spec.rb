require "spec_helper"

describe Dragon::Parser::Expression do
  let(:parser) do
    class ExampleParser < Parslet::Parser
      include Dragon::Parser::Expression
    end.new
  end

  describe "#argument" do
    it "parses `foo bar, 1, 4.5, \"word\"`"
  end

  describe "#definition" do
    it "parses `var: \"Foo\"`"
    it "parses `var: fon foo`"
    it "parses `var: 5`"
  end

  describe "#expression" do
    it "parses `fon foo`"
    it "parses `fon foo`"
  end

  describe "#function" do
    it "parses `foo(1, \"far\", foo)`"
  end
end
