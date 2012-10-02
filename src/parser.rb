module Dragon
  class Parser < Parslet::Parser
    rule(:lower) { match["a-z"] }
    rule(:upper) { match["A-Z"] }
    rule(:space) { str("\s").repeat }
    rule(:space?) { space.maybe }
    rule(:eol) { str("\n").repeat }
    rule(:eol?) { eol.maybe }
    rule(:digit) { match "[0-9]" }
    rule(:zero) { str "0" }
    rule(:integer) { match "[1-9]" }
    rule(:comma) { str "," }
    rule(:comma?) { comma.maybe }
    rule(:colon) { str ":" }
    rule(:open) { str "(" }
    rule(:close) { str ")" }
    rule(:atom) { match["a-zA-Z0-9"] }
    rule(:number) { ( zero | integer >> digit.repeat.maybe).as :number }
    rule(:word) { lower >> atom.repeat }
    rule(:arguments) { space? >> (token >> comma?).repeat >> space? }
    rule(:method) { word.as(:method) >> open >> arguments.maybe.as(:arguments) >> close }
    rule(:token) { method | word | number }
    rule(:expression) { (token >> space?).as :expression }
    rule(:expressions) { expression.repeat.maybe.as(:expressions) >> eol? }
    root(:expressions)
  end
end

    # rule(:quote) { str '"' }
    # rule(:point) { str "." }
    # rule(:positive) { str "+" }
    # rule(:negative) { str "-" }
# rule :text do
#   quote >>
#   (str('\\') >> any | quote.absent? >> any).repeat.as(:text) >>
#   quote
# end
