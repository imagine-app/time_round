require "time_round/version"
require 'active_support'

module TimeRound
  # Time#round already exists with different meaning in Ruby 1.9
  def round_off(seconds = 60)
    self.class.at((self.to_seconds / seconds).round * seconds)
  end

  def to_seconds
    # This is done to catch the inconcistence between Time and ActiveSupport::Time
    self - self.class.at(0)
  end

  def floor(seconds = 60)
    self.class.at((self.to_seconds / seconds).floor * seconds)
  end

  def ceil(seconds = 60)
    self.class.at((self.to_seconds / seconds).ceil * seconds)
  end
end

class Time
  include TimeRound
end

class ActiveSupport::TimeWithZone
  include TimeRound

  class << self
    def at(secs)
      Time.zone.at(secs)
    end
  end
end
