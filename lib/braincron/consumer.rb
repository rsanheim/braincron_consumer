require 'chatterbox'

module Braincron
  class Consumer
    include RosettaQueue::MessageHandler

    delegate :logger, :to => Braincron
    
    subscribes_to :requests
    
    options 'activemq.prefetchSize' => 1, :ack => 'client'
    
    def on_message(message)
      result = Chatterbox.publish_notice(message)
      send_result(result) 
    rescue => e
      handle_failure(message, e)
    end
    
    def handle_failure(message, exception)
      logger.error "Error processing #{message.inspect}"
      logger.error exception
      RosettaQueue::Producer.publish :exceptions, exception
    end

    def send_failure_result(message)
      send_result message.merge({"result" => "failure"})
    end
  end
end
