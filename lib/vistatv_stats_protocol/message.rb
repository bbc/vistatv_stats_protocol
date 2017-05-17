require 'json'

module VistaTV
  module StatsProtocol
    class Message
      class MalformedError < Exception; end
      
      STATUSES = %w{OK ACK DATA}
      
      attr_accessor :status, :command, :data

      def self.from_string(msg)
        attributes = deserialize(msg)
        new(attributes)
      end
      
      def self.deserialize(msg)
        split_msg = msg.split('|')
        
        status  = split_msg[0]
        command = split_msg[1]
        data    = split_msg[2..-1].to_a.join('|')
        
        [status, command, data]
      end

      def initialize(*args)
        if args.length == 1
          args = args[0] 
        end
        
        case args
        when Array
          self.status, self.command, self.data = args
        when String
          self.status, self.command, self.data = self.class.deserialize(args)
        when Hash
          args.each do |k,v|
            self.public_send("#{k}=", v)
          end
        end
      end

      def data
        @data || Hash.new
      end

      def data=(msg)
        @data = JSON.parse(msg) rescue msg
      end
        
      def serialize
        raise MalformedError unless valid?
        
        json_data = data.to_json rescue '{}'
        
        "#{status}|#{command}|#{json_data}"
      end
      
      def to_send_data
        self.serialize+"\n"
      end
      
      private

      def valid?
        STATUSES.include?(self.status) && !self.command.nil?
      end
    end
  end
end
