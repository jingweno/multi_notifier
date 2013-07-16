require "action_mailer" unless defined?(::ActionMailer)
require "multi_notifier/adapter"

module MultiNotifier
  module Adapters
    class Mail < Adapter
      class DeliveryValidator < ::ActiveModel::Validator
        def validate(model)
          if model.delivery.present?
            model.errors.add(:delivery, "method can't be blank") unless model.delivery[:method].present?
          end
        end
      end

      attr_accessor :delivery, :from, :to, :subject, :html_body, :text_body

      validates_presence_of :delivery, :from, :to, :subject, :text_body
      validates_with DeliveryValidator

      class Mailer < ActionMailer::Base
        def notificaiton(headers, text_body, html_body)
          mail headers do |format|
            format.text { text_body }
            format.html { html_body.present? ? html_body : text_body }
          end
        end
      end

      def notify
        Mailer.delivery_method = delivery[:method]
        Mailer.send("#{delivery[:method]}_settings=", delivery[:settings] || {})

        headers = {
          :from => from,
          :to => to,
          :subject => subject
        }

        mailer = Mailer.notificaiton(headers, text_body, html_body)
        mailer.deliver

        mailer
      end
    end
  end
end
