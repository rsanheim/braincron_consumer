require 'pathname'
require 'logger'
require 'syslog_formatter' 

# TODO rip all this out with proper vendor'ed gems
braincron_vendor_gems = Pathname(__FILE__).parent.parent.parent.join("braincron", "vendor", "gems")
braincron_vendor_gems.children.each do |dir|
  $LOAD_PATH << dir.join("lib")
end

require 'active_support'
require 'rosetta_queue/consumer_managers/threaded'

module Braincron
  extend self
  extend ActiveSupport::Memoizable
  
  def root
    Pathname.new(__FILE__).join("../../").expand_path
  end
  
  def start!
    init_logging
    start_consumer
  end
  
  def logger
    logger = Logger.new(root.join("log", "braincron_consumer.log"))
    logger.formatter = SyslogFormatter.new
    logger.level = Logger::DEBUG
    logger
  end
  
  memoize :logger
  
  def start_consumer
    RosettaQueue::ThreadedManager.create do |manager|
      manager.add(Braincron::Consumer.new, "request_consumer")
    end
    manager.start
  end
  
end