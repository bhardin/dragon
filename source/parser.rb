require_relative "parser/whitespace"
require_relative "parser/letter"
require_relative "parser/number"

module Dragon
  class Parser < Parslet::Parser
    include Whitespace
    include Letter
    include Number

    # comment = "#", { any };
    rule(:comment) do
      str("#") >> any.repeat
    end


    # symbol = "?" | "!" | "_" | "@" | "$" | "%" | "^" | "&" | "/" | "\" | "~" | "-" | "|" | "=" | "*" | "<" | ">" | ";" | "+";
    rule(:symbol) do
      match['\?!_@$%^&/\\\~\-|=\*<>;\+']
    end

    # number = negative | decimal | digit
    rule(:number) do
      digit.as(:digit) | negative.as(:negative) | decimal.as(:decimal)
    end

    # character = letter | digit | symbol;
    rule(:character) do
      letter | digit | symbol
    end

    # word = character, { character };
    rule(:word) do
      character.repeat(1)
    end

    rule(:single) { str("'") }

    # single quoted = "'", [{ '\', ANY | "'"?, ANY }], "'";
    rule(:single_quoted) do
      single >> ((str('\\') >> any) | (single.absent? >> any)).repeat >> single
    end

    rule(:double) { str('"') }

    # double quoted = '"', [{ '\', ANY | '"'?, ANY }], '"';
    rule(:double_quoted) do
      double >> ((str('\\') >> any) | (double.absent? >> any)).repeat >> double
    end

    # text = single quote | double quote
    rule(:text) do
      (single_quoted | double_quoted).as(:text)
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
