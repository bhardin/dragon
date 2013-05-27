require 'minitest/autorun'
require_relative '../dragon'

class TestParser < MiniTest::Unit::TestCase
  attr_accessor :parser
  def setup
    self.parser = Dragon::Parser.new
  end
end
