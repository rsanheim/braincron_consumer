require 'spec_helper'

describe Braincron::Consumer do
  def stub_message(overrides = {})
    options = { 
      :message => { :summary => "here is a message" },
      :config => { 
        :to => "joe@example.com", 
        :from => "someone@here.com" 
      }
    }.merge(overrides)
  end
  
  describe "on_message" do
    before do
      # NOTE: may want to move this into spec helper
      Braincron.configure
    end
    
    it "should send message to Chatterbox" do
      message = stub_message
      Chatterbox.expects(:publish_notice).with(message)
      Braincron::Consumer.new.on_message(message)
    end
    
    it "should send an email" do
      p ActionMailer::Base.delivery_method
      lambda {
        Braincron::Consumer.new.on_message(stub_message)
      }.should change(ActionMailer::Base.deliveries, :size)
    end
  end
end