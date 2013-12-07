require "travis" unless defined?(::Travis)
require "multi_notifier/middleware"

module MultiNotifier
  module Middlewares
    class Travis < Middleware
      attr_accessor :access_token, :repo, :travis_pro

      validates_presence_of :access_token, :repo

      def notify
        host = travis_pro? ? ::Travis::Client::PRO_URI : ::Travis::Client::ORG_URI
        client = travis_client(host, access_token)
        repo = client.repo(repo)
        repo.last_build.restart
      end

      def travis_pro?
        !!travis_pro
      end

      private

      def travis_client(host, access_token)
        ::Travis::Client.new "uri" => host, "access_token" => access_token
      end
    end
  end
end
