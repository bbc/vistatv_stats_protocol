module StatsProtocol
  class Command
    class NotFoundError < Exception; end
    attr_reader :message, :type, :param
    
    def initialize(*args)
      if args.count == 1
        args = args.first
      end

      case args
      when String
        @message = args.chomp
        @type, @param = parse
      when Hash
        @type = args[:type].to_sym
        @param = args[:param].to_sym
        parse
      when Array
        @type, @param = args
        parse
      end
    end

    def message
      return @message unless @message.nil?
      @message = type.to_s
      @message += "_#{param}" unless param.nil?
    end

    def serialize
      message+"\n"
    end
    
    private
    def parse
      case message.downcase
      when 'discovery'
        [:discovery, nil]
      when 'overview'
        [:overview, nil]
      when /^station_([\w\d_]+)$/
        [:station, $1.to_sym]
      when /^stop_([\w\d_]+)$/
        [:stop, $1.to_sym]
      else
        raise NotFoundError, "#{message} not understood"
      end
    end
  end
end

