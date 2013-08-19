require "coveralls"
Coveralls.wear! do
  add_filter "/spec/"
end

require_relative "../dragon"

module SpecHelper
  def parse(subparser, value)
    parser.send(subparser).parse(value)
  end
end

RSpec.configure do |config|
  config.include SpecHelper
end
