require 'minitest/autorun'
require_relative '../dragon'

class TestTransformer < MiniTest::Unit::TestCase
  def setup
    @parser = Dragon::Parser.new
    @transformer = Dragon::Transformer.new
  end

  def method_name

  end
end
