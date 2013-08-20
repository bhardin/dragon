module Dragon
  class Parser < Parslet::Parser
    module Quote
      # single quoted = "'", [{ '\', ANY | "'"?, ANY }], "'";
      def single_quoted
        str("'") >> ((str('\\') >> any) | (str("'").absent? >> any)).repeat >> str("'")
      end

      # double quoted = '"', [{ '\', ANY | '"'?, ANY }], '"';
      def double_quoted
        str('"') >> ((str('\\') >> any) | (str('"').absent? >> any)).repeat >> str('"')
      end

      # text = single quote | double quote
      def text
        (single_quoted | double_quoted).as(:text)
      end
    end
  end
end
