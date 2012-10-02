require 'minitest/autorun'
require_relative '../dragon'

class TestParser < MiniTest::Unit::TestCase
  def setup
    @engine = Dragon::Parser.new
  end

  def slice(string, size = 0)
    Parslet::Slice.new string, size
  end

  def expected_single_token(token, string, slice = 0)
    [{ token => slice(string, slice) }]
  end

  def test_return_of_word
    expected = expected_single_token :word, "test"
    actual = @engine.parse("test")
    assert_equal(expected, actual)

    expected = expected_single_token :word, "tEST"
    actual = @engine.parse("tEST")
    assert_equal(expected, actual)

    expected = expected_single_token :word, "tEst"
    actual = @engine.parse("tEst")
    assert_equal(expected, actual)

    expected = expected_single_token :word, "tEst9"
    actual = @engine.parse("tEst9")
    assert_equal(expected, actual)

    expected = expected_single_token :word, "tEst92"
    actual = @engine.parse("tEst92")
    assert_equal(expected, actual)

    expected = expected_single_token :word, "tEst92e"
    actual = @engine.parse("tEst92e")
    assert_equal(expected, actual)

    expected = expected_single_token :word, "t"
    actual = @engine.parse("t")
    assert_equal(expected, actual)
  end

  def test_return_of_constant
    expected = expected_single_token :constant, "T"
    actual = @engine.parse("T")
    assert_equal(expected, actual)

    expected = expected_single_token :constant, "TEST"
    actual = @engine.parse("TEST")
    assert_equal(expected, actual)

    expected = expected_single_token :constant, "TEsT"
    actual = @engine.parse("TEsT")
    assert_equal(expected, actual)

    expected = expected_single_token :constant, "T3sT"
    actual = @engine.parse("T3sT")
    assert_equal(expected, actual)

    expected = expected_single_token :constant, "Test"
    actual = @engine.parse("Test")
    assert_equal(expected, actual)

    expected = expected_single_token :constant, "TEsT42"
    actual = @engine.parse("TEsT42")
    assert_equal(expected, actual)
  end

  def test_return_of_number
    expected = expected_single_token :number, "0"
    actual = @engine.parse("0")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "12345"
    actual = @engine.parse("12345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "-12345"
    actual = @engine.parse("-12345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "12e345"
    actual = @engine.parse("12e345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "-12e345"
    actual = @engine.parse("-12e345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "-12e-345"
    actual = @engine.parse("-12e-345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "12e-345"
    actual = @engine.parse("12e-345")
    assert_equal(expected, actual)
    expected = expected_single_token :number, "1.2e345"
    actual = @engine.parse("1.2e345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "-1.2e345"
    actual = @engine.parse("-1.2e345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "-1.2e-345"
    actual = @engine.parse("-1.2e-345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "1.2e-345"
    actual = @engine.parse("1.2e-345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "12.345"
    actual = @engine.parse("12.345")
    assert_equal(expected, actual)

    expected = expected_single_token :number, "-12.345"
    actual = @engine.parse("-12.345")
    assert_equal(expected, actual)
  end

  def test_return_of_text
    expected = expected_single_token :text, "An example", 1
    actual = @engine.parse("\"An example\"")
    assert_equal(expected, actual)
  end

  def test_return_of_method
    expected = expected_single_token :method, expected_single_token(:word, "puts").first
    actual = @engine.parse("puts()")
    assert_equal(expected, actual)

    expected = [{:method=>[{:word=>slice("puts")}, {:text=>slice("Hello, World!",6)}]}]
    actual = @engine.parse('puts("Hello, World!")')
    assert_equal(expected, actual)

    expected = [{:method=>[{:word=>slice("puts")},{:text=>slice("Hello, World!",6)},{:text=>slice("Fuck, Off!", 23)},{:text=>slice("Fella",37)}]}]
    actual = @engine.parse('puts("Hello, World!", "Fuck, Off!", "Fella")')
    assert_equal(expected, actual)

    expected = [{:method=>[{:word=>slice("puts")}, {:number=>slice("1",5)}, {:number=>slice("2",8)}]}]
    actual = @engine.parse('puts(1, 2)')
    assert_equal(expected, actual)

    expected = [{:method=>[{:word=>slice("puts")}, {:method=>[{:word=>slice("puts",5)}, {:number=>slice("1",10)}, {:number=>slice("2",13)}]}]}]
    actual = @engine.parse('puts(puts(1, 2))')
    assert_equal(expected, actual)
  end

  def test_return_of_multiple_expressions
    expected = [{:number=>slice("1")}, {:method=>[{:word=>slice("add",2)}, {:number=>slice("2",6)}]}]
    actual = @engine.parse('1 add(2)')
    assert_equal(expected, actual)

    expected = [{:number=>slice("1")}, {:method=>[{:word=>slice("add",2)}, {:number=>slice("2",6)}]}, {:method=>[{:word=>slice("add",9)}, {:number=>slice("2",13)}]}]
    actual = @engine.parse('1 add(2) add(2)')
    assert_equal(expected, actual)
  end

  def test_
    # [3] pry(main)> tree = @parser.parse "[1, 2, 3] push(4)"
    # Parslet::UnconsumedInput: Don't know what to do with "[1, 2, 3] " at line 1 char 1.
    # from /Users/krainboltgreene/.rvm/gems/rbx-head@dragon/gems/parslet-1.4.0/lib/parslet/cause.rb:63:in `raise'
    assert false
  end
end
