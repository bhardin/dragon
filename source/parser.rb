require_relative "parser/whitespace"
require_relative "parser/letter"
require_relative "parser/number"
require_relative "parser/quote"
require_relative "parser/expression"
require_relative "parser/container"

module Dragon
  class Parser < Parslet::Parser
    include Whitespace
    include Letter
    include Number
    include Quote
    include Expression
    include Container

    # comment = "#", { any };
    rule(:comment) do
      str("#") >> any.repeat
    end

    # symbol = "?" | "!" | "_" | "@" | "$" | "%" | "^" | "&" | "/" | "\" | "~" | "-" | "|" | "=" | "*" | "<" | ">" | ";" | "+";
    rule(:symbol) do
      match['\?!_@$%^&/\\\~\-|=\*<>;\+']
    end

    # character = letter | digit | symbol;
    rule(:character) do
      letter | digit | symbol
    end

    # word = character, { character };
    rule(:word) do
      character.repeat(1)
    end

    # line = expression | definition, newline;
    rule(:line) do
      definition | expressions | newline
    end

    # lines = { line };
    rule(:lines) do
      line.repeat
    end

    root(:lines)
  end
end
