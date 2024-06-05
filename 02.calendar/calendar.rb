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

one_week = []
first_day.wday.to_i.times {one_week << "  "}

(first_day..last_day).each do |date| 
		day = date.day.to_s.rjust(2)

		if date == today
			one_week << "\e[7m#{day}\e[0m"	
		else
			one_week << day
		end
		if one_week.length == 7 || date == last_day
			puts one_week.join(" ")
			one_week = []
		end
end
puts 
