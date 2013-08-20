module Dragon
  class Parser < Parslet::Parser
    module Expression
      # function = word, ["(", arguments, ")"];
      def function
        (word.as(:message) >> (str("(") >> arguments >> str(")")).maybe).as(:function)
      end

      # arguments = [{ expression, [{ white space, ",", white space, expression }] }]
      def arguments
        (expression >> ( white_space >> str(",") >> white_space >> expression ).repeat).repeat.as(:arguments)
      end

      # expression = number | text | function, [{ space }];
      def expression
        (number | text | function) >> space.maybe
      end

      # expressions = [{ expression }];
      def expressions
        expression.repeat.as(:expressions)
      end

      # definition = word, ":", white space, expressions;
      def definition
        (word >> str(":") >> white_space >> expressions).as(:definition)
      end
    end
  end
end
