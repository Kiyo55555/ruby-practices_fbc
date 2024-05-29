#提出用

scor_arr= []
param = ARGV.map{|n| n.split(",")}
scor_arr= param[0]


# 文字列から数字へ , ストライクは 10,nilとする。(10投目だけ10,nilではなくただの10)
x = []
scor_arr.each do |d|
  if x.length < 18
    if d == "X"
        x << 10
        x << nil
    else
        x << d.to_i
    end
	else 
		if d == "X"
			x << 10
		else
			x << d.to_i
		end
	end
end

#二次元配列に収める　10フレーム目の最後があれば追加
frames =[]
x.each_slice(2) do |s|
    if frames.length <= 9
        frames << s
    else
        frames[9] << s[0]
    end
end

#スコア計算
total = 0
f_score = 0
frames.each_with_index do |n,idx|
	if idx < 9  										#10フレーム目の前と後で分ける
    if n[0] == 10                 #ストライクの場合
			if frames[idx+1][0] == 10   #次もストライクだったら、次の次のフレームを参照するする必要があるため
				f_score = 10 + 10 + ( frames[idx+1][1] || frames[idx+2][0])  #もし9フレーム目なら10フレーム目から（同じフレームから）２投を参照する要があるため
			else
				f_score = 10 + frames[idx+1][0]+frames[idx+1][1]
			end
      total += f_score
    elsif n.sum == 10							#スペアの場合
      f_score = 10 + frames[idx+1][0]
      total += f_score
    else													#普通の時
      f_score = n.sum
      total += f_score 
    end
	else 
		f_score = n.sum
		total += f_score
  end
end
p total
