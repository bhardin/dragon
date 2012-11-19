module Dragon
  class Parser < Parslet::Parser
    rule(:lower) { match["a-z"] }
    rule(:upper) { match["A-Z"] }
    rule(:operators) { match["+\\-*%^'"] | open_brace | close_brace }
    rule(:symbols) { match["&@#!?$;\\[\\]"] }
    rule(:space) { str("\s").repeat }
    rule(:space?) { space.maybe }
    rule(:eol) { str("\n") }
    rule(:eol?) { eol.maybe }
    rule(:digit) { match "[0-9]" }
    rule(:zero) { str "0" }
    rule(:integer) { match "[1-9]" }
    rule(:quote) { str '"' }
    rule(:comma) { str "," }
    rule(:comma?) { comma.maybe }
    rule(:colon) { str ":" }
    rule(:open_brace) { str "{"}
    rule(:close_brace) { str "}" }
    rule(:open_paren) { str "(" }
    rule(:close_paren) { str ")" }
    rule(:atom) { match["a-zA-Z0-9"] }
    rule(:number) { ( zero | integer >> digit.repeat.maybe).as :number }
    rule(:text) { quote >> (str('\\') >> any | quote.absent? >> any).repeat.as(:text) >> quote }
    rule(:word) { ((lower | operators | symbols) >> atom.repeat).as :word }
    rule(:argument) { space? >> token >> space? }
    rule(:assignment) { word >> colon >> space? >> expressions.as(:value) }
    rule(:method) { word >> open_paren >> argument.maybe.as(:argument) >> close_paren }
    rule(:token) { assignment | method | word | text | number }
    rule(:expression) { token >> space? }
    rule(:expressions) { expression.repeat(1).as :expressions }
    rule(:line) { (expressions >> eol.repeat).repeat(1).as :line }
    root(:line)
  end
end

