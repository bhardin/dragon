require "spec_helper"

describe Dragon::Parser::Container do
  let(:parser) do
    class ExampleParser < Parslet::Parser
      include Dragon::Parser::Expression
      include Dragon::Parser::Container
    end.new
  end

  describe("#brace_container") do
    it "parses `{ foo: bar, baz: bong }`"
  end

  describe("#bracket_container") do
    it "parses `[1, \"foo\", foo()]`"
  end
end
