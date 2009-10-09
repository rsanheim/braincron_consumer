module Braincron
  module Queue
    def self.configure
      RosettaQueue::Destinations.define do |queue|
        queue.map :requests, "/queue/braincron/requests"
        queue.map :results, "/queue/braincron/results"
        queue.map :exceptions, "/queue/braincron/exceptions"
      end

      config = Braincron.queue_config
      RosettaQueue::Adapter.define do |a|
        a.user = config["user"]
        a.password = config["password"]
        a.host = config["host"]
        a.port = config["port"]
        a.type = config["type"]
      end

      RosettaQueue::Filters.define do |filter_for|
        filter_for.receiving { |message| ActiveSupport::JSON.decode(message).with_indifferent_access }
        filter_for.sending { |hash| hash.to_json }
      end
    end
  end
end

