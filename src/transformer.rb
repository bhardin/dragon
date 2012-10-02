module Dragon
  class Transformer < Parslet::Transform
    rule(number: simple(:n)) { Integer(n) }
    rule(text: simple(:t)) { String(t) }
    rule(method: simple(:method), arguments: "") do
      [method.to_sym, []]
    end
    rule(method: simple(:method), arguments: sequence(:arguments)) do
      [method.to_sym, arguments]
    end
    rule(expression: subtree(:expression)) do
      this = expression.first.is_a?(Array) ? Thing : expression.shift
      expression.inject this do |memo, item|
        method = item.shift
        arguments = item.shift
        memo.send method, *arguments
      end
    end
  end
end
