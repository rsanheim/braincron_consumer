require 'spec_helper'

describe Braincron do
  it "loads" do
    Braincron
  end
  
  it "has a logger" do
    Braincron.logger.debug "test"
  end
end
