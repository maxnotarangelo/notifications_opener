module NotificationsOpener
  module Handler
    class Sms < Base
      attr_accessor :from,
                    :to,
                    :message

      def initialize(config, env)
        super(config, env)
        c = build_params(env['rack.input'].string)
        @from = c[:from]
        @to = c[:to]
        @message = c[:message]
      end

      def notification_type
        'sms'
      end

      private

      def build_params(q)
        p = { }

        q.split('&').each do |kv|
          kv = kv.split('=')
          p[kv[0]] = kv[1]
        end

        {
          from: CGI.unescape(p[config[:from_key_name]]),
          to: CGI.unescape(p[config[:to_key_name]]),
          message: CGI.unescape(p[config[:message_key_name]]),
          location: config[:location]
        }
      end
    end
  end
end
