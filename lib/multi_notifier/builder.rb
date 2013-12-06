require "active_support"

module MultiNotifier
  class Builder
    attr_reader :adapters

    def initialize
      @adapters = []
    end

    def use(type, configs = {})
      require "multi_notifier/adapters/#{type}"
      adapter = "MultiNotifier::Adapters::#{type.to_s.classify}".constantize
      adapters << adapter.new(configs)

      adapter
    end

    def notify_all!
      adapters.each do |adapter|
        begin
          adapter.notify!
        rescue => e
          puts "#{adapter.class.name} has error #{e.inspect}"
        end
      end
    end
  end
end
