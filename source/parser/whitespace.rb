module Dragon
  class Parser < Parslet::Parser
    module Whitespace
      # space = "\s" | "\t";
      def space
        match["\s|\t"]
      end

      # newline = "\n" | "\r";
      def newline
        match["\n|\r"]
      end

      # white space = { space };
      def white_space
        space.repeat
      end
    end
  end
end
