# Create a clock that is independent of date (time only).
# Functionality:
# - Add minutes to / subtract minutes from the time represented by a given
#   Clock object. 
#   - Do not mutate the calling Clock -- create a new Clock object.
# - Two clock objects that represent the same time should be equal (==) to each 
#   other.
# * Do not use any built-in date/time functionality - only arithmetic.

# Methods:
# Clock::at(hour, minute = 00) => Returns a new Clock object with @hour and @minute
# Clock#to_s => Returns a string representation of the clock's time (hour:minute)
# Clock#+ => Returns a new Clock object with x number of minutes added
# Clock#- => Returns a new Clock object with x number of minutes subtracted 
# Clock#== => Compares two clocks based on their time

# Rules:
# - 24h time 
# - Time should over and underflow - total number of minutes should always remain
#   within 0..1439 (23:59)
#   - If time is added and the result is > 1439, divide the total time (min) by 
#     1440, then convert the remainder to hour + minute
#   - If time is subtracted and the result is negative (<0) (avoiding - div):
#     - Divide the absolute difference by 1440, subtract the remainder from 1440,
#       then convert the remainder to hours + mins
# 
# Assume times are valid for ::at (?)

# Input 
# ::at
# - An integer (representing hour); optionally a 2nd integer representing minute
# #+ and #-
# - An integer representing the number of working minutes to add or subtract

# Output 
# ::at
# - A Clock object (@hour, @minute, @total_minutes?)
# #+ and #-
# - A NEW clock object with the updated time

# Data:
# - @hour - store the CLock's hour as an integer
# - @minute - store Clock's minute value as integer
# - @working_minutes - store the Clock's total minutes as integer
# - MINUTES_RANGE = 0...1440

# Algorithm:
# ::at
# Given one or two integers as input, hour and minute:
# - Initialize a new Clock object. Set @hour = hour, @minute = minute, and 
#   @working_minutes = hour * 60 + minute

# #+ 
# Given an integer as input, minutes_to_add:
# - Add minutes to @working_minutes (new_time = )
#   - If the result is greater than/equal to 1440, calculate the overflowed value:

#   #overflow:
#     - Divide the minutes sum by 1440 => working_minutes (remainder)
# - Convert new time to hour + minute
# - Instantiate a new Clock object

# #-
# - Subtract minutes from @working_time (new_time = )
#   - If result is less than 0, calculate the underflow:
#   # underflow:
#   - Divide the difference (absolute) by 1440; subtract the remainder from 1440
# - Convert the resulting new_time to hours + mins 
# - Instantiate a new CLock object
require 'pry'

# class Clock
#   MINUTES_RANGE = 0...1440

#   def self.at(hour, minute = 0)
#     self.new(hour, minute)
#   end

  

#   def initialize(hour, minute = 0)
#     @hour, @minute = hour, minute
#     @working_minutes = (hour * 60) + minute
#   end

#   def +(minutes_to_add)
#     new_time = working_minutes + minutes_to_add
#     new_time = overflow_minutes(new_time) if new_time > MINUTES_RANGE.max

#     new_hour, new_minute = new_time.divmod(60)
#     Clock.new(new_hour, new_minute)
#   end

#   def -(minutes_to_subtract)
#     new_time = working_minutes - minutes_to_subtract
#     new_time = underflow_minutes(new_time) if new_time < MINUTES_RANGE.min

#     new_hour, new_minute = new_time.divmod(60)
#     Clock.new(new_hour, new_minute)
#   end

#   def ==(other_clock)
#     hour == other_clock.hour && minute == other_clock.minute
#   end

#   def to_s
#     format("%02d:%02d", hour, minute)
#   end

#   protected attr_reader :hour, :minute, :working_minutes

#   private

#   def overflow_minutes(minutes)
#     minutes % 1440
#   end

#   def underflow_minutes(minutes)
#     1440 - (minutes.abs % 1440)
#   end
# end


# ===============================
# Refactor: Try to reduce repetition between + and -.
# Method that onverts minutes to hour + minute
# - Input: Integer representing the number of minutes
# - Output: 2-element array with hour and minute as elements.

class Clock
  MINUTES_IN_HOUR = 60
  MINUTES_RANGE = 0...1440

  def self.at(hour, minute = 0)
    self.new(hour, minute)
  end

  def initialize(hour, minute = 0)
    @hour, @minute = hour, minute
    @minutes_since_midnight = (hour * MINUTES_IN_HOUR) + minute
  end

  def calculate_new_total_minutes(operator, minutes)
    #binding.pry
    new_minutes = operator.to_proc.call(self.minutes_since_midnight, minutes)
    new_minutes = wrap(new_minutes) unless MINUTES_RANGE.include?(new_minutes)
    new_minutes
  end

  def wrap(minutes)
    if minutes > MINUTES_RANGE.max
      overflow(minutes )
    elsif minutes < MINUTES_RANGE.min
      underflow(minutes)
    end
  end

  def +(minutes)
    new_total_minutes = calculate_new_total_minutes(:+, minutes)

    new_hour, new_minute = minutes_to_hour_and_minute(new_total_minutes)
    Clock.new(new_hour, new_minute)
  end

  def -(minutes)
    new_total_minutes = calculate_new_total_minutes(:-, minutes)

    new_hour, new_minute = minutes_to_hour_and_minute(new_total_minutes)
    Clock.new(new_hour, new_minute)
  end

  def ==(other_clock)
    hour == other_clock.hour && minute == other_clock.minute
  end

  def to_s
    format("%02d:%02d", hour, minute)
  end

  protected attr_reader :hour, :minute, :minutes_since_midnight

  private

  def minutes_to_hour_and_minute(minutes)
    minutes.divmod(60)
  end

  def overflow(minutes)
    minutes % 1440
  end

  def underflow(minutes)
    1440 - (minutes.abs % 1440)
  end
end

# Refactor on revisit: Always wrap minutes; leave it alone if it is in range.