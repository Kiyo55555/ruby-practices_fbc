#!/usr/bin/env ruby

require 'date'
require 'optparse'

options = OptionParser.new

params = {}
options.on('-m month') {|v| v }
options.on('-y year') {|v| v }
options.parse!(ARGV, into: params)

today = Date.today
WEEKDAY_CHARACTERS_JA = ["日","月","火","水","木","金","土"]

year = params[:y] || today.year
month = params[:m] || today.month

first_day = Date.new(year.to_i, month.to_i, 1)
last_day =Date.new(first_day.year.to_i, first_day.month.to_i, -1)


calendar_label= []
calendar_label << "#{first_day.month.to_s}月" 
calendar_label << first_day.year

puts calendar_label.unshift("     ").join(" ")
puts WEEKDAY_CHARACTERS_JA.join(" ")

days_in_week = []
first_weekn = first_day.wday.to_i
first_weekn.times {days_in_week << "  "}

(first_day..last_day).each do |date| 
		day = date.day.to_s
		day = day.rjust(2)

		if date == today
			days_in_week << "\e[7m#{day}\e[0m"	
		else
			days_in_week << day
		end
		if days_in_week.length == 7 || date == last_day
			puts days_in_week.join(" ")
			days_in_week = []
		end
end
puts 
