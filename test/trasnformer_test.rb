require 'minitest/autorun'
require_relative '../dragon'

class TestTransformer < MiniTest::Unit::TestCase
  attr_accessor :parser, :transformer
  def setup
    self.parser = Dragon::Parser.new
    self.transformer = Dragon::Transformer.new
  end

  def evaluate(value)
    transformer.apply parser.parse(value)
  end

  def test_sanity
    expected = 3
    actual = evaluate("3")
    assert_equal(expected, actual)

    expected = 7
    actual = evaluate("3 +(4)")
    assert_equal(expected, actual)
  end
end
