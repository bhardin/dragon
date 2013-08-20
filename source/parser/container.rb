module Dragon
  class Parser < Parslet::Parser
    module Container
      def brace_container
        str("{") >> arguments >> str("}")
      end

      def bracket_container
        str("[") >> arguments >> str("]")
      end

      def contained
        brace_container.as(:brace) | bracket_container.as(:bracket)
      end
    end
  end
end
