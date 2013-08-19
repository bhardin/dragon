require "parslet"

module Dragon
  class Parser < Parslet::Parser
    # comment = "#", { any }
    rule(:comment) do
      str("#") >> any.repeat
    end

    # space = "\s" | "\t";
    rule(:space) do
      match["\s|\t"]
    end

    # newline = "\n" | "\r";
    rule(:newline) do
      match["\n|\r"]
    end

    # white space = { space | newline };
    rule(:white_space) do
      (space | newline).repeat
    end

    # upper letter = "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z";
    rule(:upper_letter) do
      match["A-Z"]
    end

    # lower letter = "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z";
    rule(:lower_letter) do
      match["a-z"]
    end

    # letter = upper letter | lower letter;
    rule(:letter) do
      upper_letter | lower_letter
    end

    # symbol = "?" | "!" | "_" | "@" | "$" | "%" | "^" | "&" | "/" | "\" | "~" | "-" | "|" | "=" | "*" | "<" | ">" | ";" | "+";
    rule(:symbol) do
      match['\?!_@$%^&/\\~\-|=\*<>\;+']
    end

    # integer = "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
    rule(:integer) do
      match["1-9"]
    end

    # zero = "0";
    rule(:zero) do
      str("0")
    end

    # digit = zero | integer;
    rule(:digit) do
      zero | integer
    end

    rule(:point) { str(".") }

    # decimal = integer, { digit } , ".", { digit };
    rule(:decimal) do
      ( integer >> digit.repeat(1) | digit  ) >> point >> digit.repeat(1)
    end

    # negative = "-", decimal | { digit };
    rule(:negative) do
      str("-") >> (decimal | digit.repeat(1))
    end

    # character = letter | digit | symbol;
    rule(:character) do
      letter | digit | symbol
    end

    # word = { character };
    rule(:word) do
      character.repeat(1)
    end

    rule(:single) { str("'") }

    # single quote = "'", { '\', any | "'", any }, "'"
    rule(:single_quote) do
      single >> ((str('\\') >> any) | (single.absent? >> any)).repeat >> single
    end

    rule(:double) { str('"') }

    # double quote = '"', { '\', any | '"', any }, '"'
    rule(:double_quote) do
      double >> ((str('\\') >> any) | (double.absent? >> any)).repeat >> double
    end

    # text = single quote | double quote
    rule(:text) do
      (single_quote | double_quote)
    end


    # function = word, [arguments] ;
    rule(:function) do
      (word.as(:message) >> arguments.maybe)
    end

    rule(:delimiter) { str(",") }

    # argument = ",", white space, expression;
    rule(:argument) do
      delimiter >> space.repeat(1) >> expression
    end

    rule(:open) { str("(") }
    rule(:close) { str(")") }

    # arguments = "(", { expression, { argument } }, ")";
    rule(:arguments) do
      open >> (expression >> argument.repeat).repeat.as(:arguments) >> close
    end

    # expression = function, { white space, function };
    rule(:expression) do
      (
        (
          digit.as(:digit) |
          negative.as(:negative) |
          decimal.as(:decimal) |
          text.as(:text) |
          function.as(:function)
        ) >> (space.repeat(1) >> expression).repeat
      ).as(:expression)
    end

    rule(:colon) { str(":") }

    # definition = word, ":", expression;
    rule(:definition) do
      (word >> colon >> space >> expression).as(:definition)
    end

    # line = expression | definition, newline;
    rule(:line) do
      definition| expression | newline
    end

    # lines = { line };
    rule(:lines) do
      line.repeat
    end

    root(:lines)
  end
end
