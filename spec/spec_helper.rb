$:.unshift File.expand_path("..", __FILE__)
$:.unshift File.expand_path("../../lib", __FILE__)

require "rspec"
require "multi_notifier"

RSpec.configure do |config|
end
