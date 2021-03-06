module RosettaQueue

  class BaseManager
    attr_reader :consumers

    class << self
      def create
        manager = self.new
        yield manager
        manager
      end
    end

    def initialize
      @consumers  = {}
    end

    def add(message_handler)
      key = message_handler.class.to_s.underscore.to_sym
      @consumers[key] = Consumer.new(message_handler)
    end

  end
end
