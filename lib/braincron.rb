require 'pathname'
lib = Pathname(__FILE__).join("..", "..", "lib").expand_path
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require 'logger'
require 'syslog_formatter' 

# TODO rip all this out with proper vendor'ed gems
braincron_vendor_gems = Pathname(__FILE__).parent.parent.parent.join("braincron", "vendor", "gems")
braincron_vendor_gems.children.each do |dir|
  $LOAD_PATH << dir.join("lib")
end

require 'active_support'
require 'rosetta_queue'
require 'rosetta_queue/consumer_managers/threaded'
require 'braincron/queue'
require 'braincron/consumer'

module Braincron
  extend self
  extend ActiveSupport::Memoizable
  
  def boot!
    logger.info { "Starting braincron_consumer" }
    configure_chatterbox
    configure_queue
    setup_consumer
    start_consumer
  end

  def root
    Pathname.new(__FILE__).join("../../").expand_path
  end
  
  def logger
    logger = Logger.new(root.join("log", "consumer.log"))
    logger.formatter = SyslogFormatter.new
    logger.level = Logger::DEBUG
    logger
  end
  
  memoize :logger
  
  def env
    ENV["BRAINCRON_ENV"]
  end
  
  def configure_chatterbox
    Chatterbox::Publishers.register do |notice|
      Chatterbox::Email.deliver(notice)
    end
  end
  
  def queue_config 
    YAML.load_file(root.join("config", "activemq.yml")).fetch(env) do
       raise(IndexError, "No config values found for #{env.inspect} in config/activemq.yml")
    end
  end
  
  def configure_queue
    Braincron::Queue.configure
  end
  
  def setup_consumer
    RosettaQueue.logger = logger
  end
  
  def start_consumer
    RosettaQueue::ThreadedManager.create do |manager|
      manager.add(Braincron::Consumer.new, "request_consumer")
      manager.start
    end
  end
  
end