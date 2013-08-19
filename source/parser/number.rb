module Dragon
  class Parser < Parslet::Parser
    module Number
      # integer = "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
      def integer
        match["1-9"]
      end

      # zero = "0";
      def zero
        str("0")
      end

      # digit = zero | integer;
      def digit
        zero | integer
      end

      def point; str(".") end

      # decimal = integer, { digit } , ".", { digit };
      def decimal
        ( integer >> digit.repeat(1) | digit  ) >> point >> digit.repeat(1)
      end

      # negative = "-", decimal | { digit };
      def negative
        str("-") >> (decimal | digit.repeat(1))
      end
    end
  end
end
