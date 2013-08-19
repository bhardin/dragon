require_relative "parser/whitespace"
require_relative "parser/letter"
require_relative "parser/number"
require_relative "parser/quote"

module Dragon
  class Parser < Parslet::Parser
    include Whitespace
    include Letter
    include Number
    include Quote

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

    rule(:open) { str("(") }
    rule(:close) { str(")") }

    # function = word, ["(", arguments, ")"];
    rule(:function) do
      (word.as(:message) >> (open >> arguments >> close).maybe).as(:function)
    end

    rule(:delimiter) { str(",") }

    # arguments = [{ expression, [{ white space, ",", white space, expression }] }]
    rule(:arguments) do
      (expression >> ( white_space >> delimiter >> white_space >> expression ).repeat).repeat.as(:arguments)
    end

    # expression = number | text | function, [{ space }];
    rule(:expression) do
      (number | text | function) >> space.maybe
    end

    # expressions = [{ expression }];
    rule(:expressions) do
      expression.repeat.as(:expressions)
    end

    rule(:colon) { str(":") }

    # definition = word, ":", white space, expressions;
    rule(:definition) do
      (word >> colon >> white_space >> expressions).as(:definition)
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
