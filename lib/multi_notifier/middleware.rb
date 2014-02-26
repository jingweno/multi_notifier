require "active_model"
require_relative "model" unless defined?(ActiveModel::Model)

module MultiNotifier
  module Middlewares
    class Middleware
      include ActiveModel::Model

      def notify
        raise "Implement #{self.class.name}#notify"
      end

      def notify!
        raise error_msg(errors.messages) unless valid?

        notify
      end

      private

      def error_msg(messages)
        messages.map do |key, value|
          value.map { |v| "#{key} #{v}" }
        end.flatten.join("\n")
      end
    end
  end
end
