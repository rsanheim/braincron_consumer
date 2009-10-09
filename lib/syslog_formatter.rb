require 'English'
require 'logger'

class SyslogFormatter < Logger::Formatter
  def call(severity, timestamp, progname, msg)
    "#{timestamp.strftime("%b %d %H:%M:%S")} [#{$PID}]: #{severity} - #{msg2str(msg).lstrip}\n"
  end
end
