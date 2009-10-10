gem 'spicycode-micronaut'
require 'micronaut'
require 'mocha'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'chatterbox'
require 'chatterbox/email'

ActionMailer::Base.delivery_method = :test

def not_in_editor?
  !(ENV.has_key?('TM_MODE') || ENV.has_key?('EMACS') || ENV.has_key?('VIM'))
end

def valid_options(overrides = {})
  options = { 
    :message => { :summary => "here is a message" },
    :config => { 
      :to => "joe@example.com", 
      :from => "someone@here.com" 
    }
  }.merge(overrides)
end

Micronaut.configure do |c|
  c.color_enabled = not_in_editor?
  c.filter_run :focused => true
end