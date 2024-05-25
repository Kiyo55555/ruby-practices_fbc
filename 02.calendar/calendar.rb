require 'date'
require 'optparse'

opt = OptionParser.new

params = {}
opt.on('-m month') {|v| v }
opt.on('-y year') {|v| v }
opt.parse!(ARGV, into: params)

tday= Date.today
week = ["日","月","火","水","木","金","土"]

#paramsの値を修正
if params[:y].nil?
	params[:y] = tday.strftime('%Y')
end
if params[:m].nil?
	params[:m] = tday.strftime('%m')
else
	params[:m] = params[:m]
end

#paramで指定された日時の一日を設定（基準日）　paramがなければ当月1日
stdday = Date.new(params[:y].to_i,params[:m].to_i,1)

#トップに表示されるの年と月
year_mon= []

year_mon << "#{stdday.strftime('%m').to_s}月" 
year_mon << stdday.strftime('%Y')

#月の日数 30 or 31 or 28 or 29
m_end_day =Date.new(stdday.strftime('%Y').to_i,stdday.strftime('%m').to_i,-1).strftime('%d').to_i

#月の1日の曜日（数字）日曜だったら0にする（これを元に月初の日付の位置を合わせるため）
first_weekn = stdday.strftime('%u').to_i == 7 ? 0 : stdday.strftime('%u').to_i


puts year_mon.unshift("    ").join(" ")
puts week.join(" ")


line = []  #7日分ずつ追加してプリントすることにする
#以下、日付の記述の処理
#tdayが含まれる月かどうかで分岐する（色をつけるため）
if tday.strftime("%m") == stdday.strftime("%m") && tday.strftime("%Y") == stdday.strftime("%Y")
	(1..m_end_day).each do |d|          #月末までのrangeでループ
		if d == 1                       #1日の時だけ曜日を合わせるために空白を入れる
			first_weekn.times do |n|    
				line << "　"            #曜日の番号の回数、空白を加える
			end
		end
		if d < 10   								# そのままやると1と10の桁数で幅が変わるので分岐
			if d == tday.strftime("%d").to_i        # 今日と同じ日付になったら色を付ける、それ以外はそのままlineに追加
				line << "\e[38;5;255m\e[40m#{d}\e[0m"
			else
				line << d.to_s.rjust(2)  
			end
		else
			if d == tday.strftime("%d").to_i
				line << "\e[38;5;255m\e[40m#{d}\e[0m"
			else
				line << d.to_s
			end
		end

		if line.length == 7 || d == m_end_day  #7日たまったら　or 末日になったら プリント
			puts line.join(" ")
			line = []
		end
	end
else
	(1..m_end_day).each do |d|
		if d == 1
			first_weekn.times do |n|
				line << "　"
			end
		end
		if d < 10
			line << d.to_s.rjust(2)
		else 
			line << d
		end

		if line.length == 7 || d == m_end_day  #7日たまったらずつ追加してプリントすることにする
			puts line.join(" ")
			line = []
		end
	end
end
puts #空白
