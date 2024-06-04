#!/usr/bin/env rub

require 'date'
require 'optparse'

opt = OptionParser.new

params = {}
opt.on('-m month') {|v| v }
opt.on('-y year') {|v| v }
opt.parse!(ARGV, into: params)

today= Date.today
week = ["日","月","火","水","木","金","土"]

if params[:y].nil?
	params[:y] = today.year
end
if params[:m].nil?
	params[:m] = today.month
end

firstday = Date.new(params[:y].to_i,params[:m].to_i,1)
endday =Date.new(firstday.year.to_i, firstday.month.to_i, -1)


#トップに表示する年と月
year_mon= []
year_mon << "#{firstday.month.to_s}月" 
year_mon << firstday.year

puts year_mon.unshift("     ").join(" ")
puts week.join(" ")


#以下、日付の記述の処理
#lineに7日分ずつ追加してプリントする
line = []

#月の1日の曜日（数字）日曜だったら0にする（月初の日付の位置を合わせるため）
first_weekn = firstday.cwday.to_i == 7 ? 0 : firstday.cwday.to_i
first_weekn.times {line << "　"} 

(firstday..endday).each do |date| 
		day = date.day.to_s
		day = day.rjust(2) if day.length == 1

		if date == today
			line << "\e[7m#{day}\e[0m"	
		else
			line << day
		end
		if line.length == 7 || date == endday
			puts line.join(" ")
			line = []
		end
end
puts #空白
