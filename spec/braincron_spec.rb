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
end
