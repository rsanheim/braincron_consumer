require 'spec_helper'

describe Braincron do
  it "loads" do
    Braincron
  end
  
  it "has a logger" do
    Braincron.logger.debug "test"
  end
  
  describe "boot!" do
    it "should start consumer" do
      Braincron.expects(:start_consumer)
      Braincron.boot!
    end
  end
  
  it "should be in test env" do
    Braincron.env.should == "test"
  end
  
  describe "queue_config" do
    it "should load config from YAML file" do
      YAML.expects(:load_file).returns({"test" => {"test" => "config"}})
      Braincron.queue_config.should == {"test" => "config"}
    end
  end
  
  describe "configure_action_mailer" do
    it "should return test for test mode" do
      Braincron.configure_action_mailer
      ActionMailer::Base.delivery_method.should == :test
    end
  end
end
