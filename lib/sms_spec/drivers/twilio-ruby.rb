module Twilio::REST
  class Client
    def initialize(account_sid, auth_token)
      $account_sid = account_sid
    end

    def account
      account = Account.new
      account.class.send(:define_method, :sid, lambda { $account_sid })
      account
    end

    class Message
      attr_accessor :number
      attr_accessor :body

      include SmsSpec::Util

      def initialize(opts={})
        @number = sanitize opts[:number]
        @body = opts[:body]
      end
    end

    class Sms
      def messages
        Messages.new
      end
    end

    class Account
      def messages
        Messages.new
      end

      def sms
        Sms.new
      end
    end

    class Messages
      include SmsSpec::Helpers

      def create(opts = {})
        add_message Message.new(number: opts[:to], :body => opts[:body])
      end
    end
  end
end
