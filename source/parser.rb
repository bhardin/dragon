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

    root(:lines)

    # comment = "#", { any };
    def comment
      str("#") >> any.repeat
    end

    # symbol = "?" | "!" | "_" | "@" | "$" | "%" | "^" | "&" | "/" | "\" | "~" | "-" | "|" | "=" | "*" | "<" | ">" | ";" | "+";
    def symbol
      match['\?!_@$%^&/\\\~\-|=\*<>;\+']
    end

    # character = letter | digit | symbol;
    def character
      letter | digit | symbol
    end

    # word = character, { character };
    def word
      character.repeat(1)
    end

    # line = expression | definition, newline;
    def line
      definition | expressions | newline
    end

    # lines = { line };
    def lines
      line.repeat
    end
  end
end
