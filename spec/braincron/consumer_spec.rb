require 'spec_helper'

describe Braincron::Consumer do
  def stub_message(overrides = {})
    options = { 
      :reminder_id => 10,
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
    
    describe "when publishing is successful" do
      it "should publish message with Chatterbox" do
        Braincron::Consumer.stubs(:publish_result)
        message = stub_message
        Chatterbox.expects(:publish_notice).with(message)
        Braincron::Consumer.new.on_message(message)
      end
      
      it "should send an email" do
        Braincron::Consumer.stubs(:publish_result)
        lambda {
          Braincron::Consumer.new.on_message(stub_message)
        }.should change(ActionMailer::Base.deliveries, :size)
      end
      
      it "should send back response indicating success" do
        response = {:reminder_id => 10, :response => { :success => true } }
        Braincron::Consumer.expects(:publish_result).with(response)
        Braincron::Consumer.new.on_message(stub_message)
      end
    end
  end
end