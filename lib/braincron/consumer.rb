require 'braincron'

module Braincron
  class Consumer
    include RosettaQueue::MessageHandler

    delegate :logger, :to => Braincron
    delegate :publish_result, :to => self
    
    subscribes_to :requests
    
    options 'activemq.prefetchSize' => 1, :ack => 'client'

    def self.publish_result(message)
      RosettaQueue::Producer.publish(:results, message)
    end
    
    def on_message(message)
      result = Chatterbox.publish_notice(message)
      send_success_response(message)
    rescue => e
      handle_failure(message, e)
    end
    
    def send_success_response(message)
      message = {:reminder_id => message[:reminder_id], :response => { :success => true } }
      publish_result(message)
    end
    
    def handle_failure(message, exception)
      logger.error "Error processing #{message.inspect}"
      logger.error exception
      p exception
      # RosettaQueue::Producer.publish :exceptions, exception
    end

    def send_failure_result(message)
      send_result message.merge({"result" => "failure"})
    end
  end
end
