module Lyra::TimeHelper
  extend self

  def format_duration(duration, format="%-M:%S")
    t = Time.mktime(0) + (duration * 1.0).round
    t.strftime(format)
  end
end