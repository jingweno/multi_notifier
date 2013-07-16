require "multi_notifier/version"
require "multi_notifier/builder"

module MultiNotifier
  def self.build
    builder = Builder.new
    yield builder if block_given?

    builder
  end
end
