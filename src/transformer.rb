module Dragon
  class Transformer < Parslet::Transform
    rule(number: simple(:n)) { Integer(n) }

    rule(text: simple(:t)) { String(t) }

    rule(word: simple(:word)) { [:instance_variable_get, :"@#{word}"] }

    rule(word: simple(:word), argument: simple(:argument)) do
      [word.to_sym, argument]
    end

    rule(word: simple(:word), value: subtree(:value)) do
      [:instance_variable_set, [:"@#{word}", value]]
    end

    rule(expressions: subtree(:expressions)) do
      @@world ||= Thing.new
      this = expressions.first.is_a?(Array) ? @@world : expressions.shift
      expressions.inject this do |memo, item|
        # puts "Memo: #{memo}, Item: #{item}"
        memo.send item.shift, *item.shift
      end
    end

    rule(line: sequence(:line)) { line.last }
  end
end
