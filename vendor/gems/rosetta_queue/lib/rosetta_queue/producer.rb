module RosettaQueue

  class Producer < Base
    include MessageHandler

    def self.publish(destination, message, options = {})
      ExceptionHandler::handle(:publishing,
        lambda {
          {:message => Filters.safe_process_sending(message),
           :action => :publishing,
           :destination => destination,
           :options => options}
        }) do
        RosettaQueue::Adapter.instance.send_message(
          Destinations.lookup(destination),
          Filters.process_sending(message),
          options)
      end
    end
  end
end
