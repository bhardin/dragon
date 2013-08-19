module Dragon
  class Parser < Parslet::Parser
    module Letter
      # upper letter = "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z";
      def upper_letter
        match["A-Z"]
      end

      # lower letter = "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z";
      def lower_letter
        match["a-z"]
      end

      # letter = upper letter | lower letter;
      def letter
        upper_letter | lower_letter
      end
    end
  end
end
