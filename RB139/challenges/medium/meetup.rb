# Meetups.

# Meetups typically happen monthly, on the same day of the week (?)
# eg. First Monday of Jan 2021; Third Tuesday of December 2020; etc.

# Create a program that constructs/returns an object representing a meetup date.
# Methods:
# #new: Takes two integers representing a Year and a Month.
# #day: Takes two strings representing the Day and the Series Position (eg. first)

# Input: 
# - Integer (represents Year)   #new
# - Integer (represents Month)  #new
# - String (represents Day)          #day
#   - Case-insensitive
# - String (represents Ordinal Day)  #day
#   - Case-insensitive
#   - teenth: There are 7 days that end in teenth: 13, 14, 15, 16, 17, 18, 19
#     - Each day of the week (Mon..Fri) is guaranteed to have exactly one day 
#       where the day ends in "teenth".

# Output:
# A Date object representing the exact specified Date.
# eg. The First Thursday in August 2024 is August 1, 2024 
#     (Date::civil - year, month, day)
# - If the specified Date is invalid (eg. 5th Monday of August 2024), return nil

# Examples:
# August 2024:
# - first, thursday => August 1, 2024 
# - fourth, thursday => August 22, 2024
# - teenth, tuesday =>  August 13, 2024

# Data:
# #new: Construct a new Meetup object; store @year and @month as integers.
#   - Perhaps construct a new Date object using year and month, default day = 1
#     Date.new(2024, 8)
# #day:
# - Convert the series_position string into a number 
#   eg. first => 1, second => 2, third => 3, fourth => 4, fifth => 5
#   (shouldn't need to go past 5)
#   * teenth? => special case, ignore for now
# - Create a hash separating each day of the month into __days:
#   { monday: [Date(Aug 5, 2024); Date(August 12, 2024...)],
#     ...
#     sunday: [Date(Aug 4, 2024)...Date(August 25, 2024)] }
# - Find the appropriate date from the hash:
#   dates_by_days[<day>] => Returns array of eg. mondays [Date(Aug 5, 2024); Date(August 12, 2024...)]
#   - Retrieve the one at index <ordinal_day number> - 1.
#  eg. First Monday:
#   dates_by_days[monday] => [Date(aug 5 2024), Date(aug 12 2024), ...]
#   mondays[ordinal_to_number - 1]
#           => first (1) - 1 => 0
#   mondays[0] => Date(aug 5 2024) 

# Algorithm:
# Given a Year, Month, x_day, and ordinal number:
# - Construct a Meetup object; initialize @date = Date.new(year, month)
# #day:
# - Create a conversion table (hash) for ordinal number:
#   ie. ordinal_to_integer
#     { 'first' => 1, 'second' => 2, ..., 'fifth' => 5 }

# - Create a dates_by_days hash, grouping the dates of the month by days:
#   - Initialize a new variable, working date = @date
#   - While workingdate month is equal to @date month:
#     - Find the day of the week: #wday, returns integer 0-6.
#       - Convert returned integer to a string using DAYNAMES[int]
#         [Sunday, Monday, ..., Saturday]
#     - Add the current date to the hash:
#       dates_by_days['day'] << date OR dates_by_days['day'] = [date] (if not key alr)
#     - Increment date by 1 (reassign).
#   - Exit iteration when date.month is no longer == @date.month
# - Retrieve the correct date from the hash:
#   eg. dates_by_days[x_day][ordinal_to_integer[ordinal]]

# TEENTH:
# - Select the date from the appropriate day array that has a day value between 
#   13 and 19.
#   eg. dates_by_days[x_day].find { |date| date.day.between?(13, 19) }

# If x_dayarray[ordinal_to_int] cannot be found, return nil.

require 'pry'

# class Meetup
#   ORDINAL_TO_INT = { 
#     'First' => 1, 'Second' => 2, 'Third' => 3, 
#     'Fourth' => 4, 'Fifth' => 5
#   }

#   TEEN_DAYS = 13..19

#   attr_reader :date, :dates_by_day

#   def initialize(year, month)
#     @date = Date.new(year, month)
#     @dates_by_day = group_dates_by_day
#   end

#   def day(x_day, ordinal)
#     x_day, ordinal = x_day.capitalize, ordinal.capitalize

#     relevant_dates = dates_by_day[x_day.capitalize]


#     if ordinal == 'Teenth'
#       relevant_dates.find { |date| TEEN_DAYS.include?(date.day) }
#     elsif ordinal == 'Last'
#       relevant_dates.last
#     else
#       relevant_dates[ORDINAL_TO_INT[ordinal] - 1]
#     end
    
#   end

#   private

#   def group_dates_by_day
#     working_date = @date

#     days = { }
#     while working_date.month == date.month
#       day = Date::DAYNAMES[working_date.wday]
#       if days.key?(day) 
#         days[day] << working_date
#       else
#         days[day] = [working_date]
#       end
#       working_date = working_date.next
#     end
#     days
#   end
# end


#================================================
# Refactor: Launch School Solution
#  Summary: Filter for the relevant week, then find the correct day.
# - The first weekday of the month is in the first week of the month - ie., it is
#   always between day 1 and day 7.
#   - Second weekday => Day 8-14; Third weekday => 15-21; 
#     Fourth weekday => 22-28
#   - Fifth weekday does not exist for all weekdays; but it always starts at 
#     day 29. 
# - The teenth weekday of the month is always between 13-19.
# - The last weekday of the month always occurs in the last week of the month...
#   therefore, it always starts 6 days before the last DAY of the month.
#   ie. Date.new(year, month, -1).prev_day(6).day

# Data:
# - Save @year and @month

# - Hash structure storing ordinal (eg. second) => day # of the first
#   day in the (ordinal) week
# eg. { first: 1, second: 8, third: 15, fourth: 22, fifth: 29,
#       teenth: 13 }
# Last Day is dynamic - last: Date.new(year, month, -1).prev_day(6).day }

# Meetup#initialize(year, month)
# 
# Meetup#day(x_day, nth)
# - Determine which day? to check for. eg. If x-day == monday, check for monday?
#   (Return a proc?)
# - Start from the FIRST date OF THE NTH WEEK and iterate through date progressively.
#   - If the current date is no longer in the same month, exit iteration and return
#     nil (no date found). Otherwise:
#   - Check if the current date is a _day? (call Proc). If it is, return the 
#     current date. Otherwise:
#   - Increment date by 1 day and repeat.

# class Meetup
#   FIRST_DAY_OF_NTH_WEEK = {
#     'first' => 1, 'second' => 8, 'third' => 15, 
#     'fourth' => 22, 'fifth' => 29, 'teenth' => 13
#   }
  
#   def initialize(year, month)
#     @year, @month = year, month
#   end

#   def day(x_day, nth)
#     day_checker = correct_day(x_day)

#     last_date_of_month = Date.new(year, month, -1)
#     first_possible_date = Date.new(year, month, first_day_of_nth_week(nth))
#     first_possible_date.step(last_date_of_month) do |date|
#       return date if day_checker.call(date)
#     end
    
#     nil
#   end

#   private

#   attr_reader :year, :month

#   def day_checker(x_day)
#     (x_day.downcase + '?').to_sym.to_proc
#   end

#   def first_day_of_nth_week(nth)
#     case nth.downcase
#     when 'last' then first_day_of_last_week
#     else             FIRST_DAY_OF_NTH_WEEK[nth.downcase]
#     end
#   end

#   def first_day_of_last_week
#     Date.new(year, month, -1).prev_day(6).day
#   end
# end


# ===========================
# Refactor:
# 1) Select all of the specified weekdays in the given month.
# 2) Find the date corresponding to the specified nth (first) descriptor

#   Exceptions: Last and teenth
#   - Last: Select all specified weekdays in the given month, then pick the last one
#   - Teenth: Select all specified weekdays in the given month, then find the one whose 
#     day is between 13 and 19.

class Meetup
  NTH_DESCRIPTORS = ['first', 'second', 'third', 'fourth', 'fifth']

  def initialize(year, month)
    @year, @month = year, month
    @days_in_month = Date.new(year, month)..Date.new(year, month, -1)
  end

  def day(x_day, nth_descriptor)
    x_day, nth_descriptor = x_day.downcase, nth_descriptor.downcase

    day_checker = (x_day + '?').to_sym.to_proc
    x_days_in_month = days_in_month.select(&day_checker)

    case nth_descriptor
    when 'teenth' then x_days_in_month.find { |date| date.day.between?(13, 19) }
    when 'last'   then x_days_in_month.last
    else               x_days_in_month[NTH_DESCRIPTORS.index(nth_descriptor)]
    end
  end

  private attr_reader :year, :month, :days_in_month
  
end






