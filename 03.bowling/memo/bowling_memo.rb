#作業用
require 'debug'

scor_arr= []
param = ARGV.map{|n| n.split(",")}
scor_arr= param[0]

# .map {|n| scor_arr << n.split(",")}[0].each do |s|
#     s.each do |m|
#         scor_arr << m
#     end
# end


total = 0

#2ずつ読み取る
#totalに追加
#Xなら二個分消化
#合計10ならadditional（次に加算）



#１０投目が2回でも3回でも
#二次元配列に収めることができる

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

frames =[]
x.each_slice(2) do |s|
    if frames.length <= 9
        frames << s
    else
        frames[9] << s[0]
    end
end
p frames

# x = []
# y= []
# scor_arr.each do |d|
#     if x.length < 9
#         if d == "X"
#             x << [d]
#         else
#             d = d.to_i
#             y << d
#             if y.length == 2
#                 x << y
#                 y = []
#             end
#         end
#     else
#         if d == "X"
#             y << d
#             if y.length == 3
#                 x << y
#             end
#         else
#             d = d.to_i
#             y << d
#             if y.length == 3 
#                 x << y
#             elsif y.length == 2 && !y.include?("X") && y.sum!=10
#                 x << y
#             end
#         end
#     end
# end

# p x
# p x.length

# 収集したxをもとに計算する 
# 配列のlengthが2なら
# スペア 一個の配列の合計が10なら
# 配列の中身がXなら

#ストライク、スペアの後に普通のスコアの場合
#スペアが続いた場合
#ストライクが続いた場合

#とりあえずこのまま書く（関数に分けない）

# sig をつける＝次の処理に加算する＝一旦その時の処理は気にしなくていい

#プログラムの中に遊びを入れる こうだったら良いのに的な機能を考えて足してみる 要件を達成するだけでなく、楽しみを入れる
# def cal_score(arr, sig, idx)
#     score = 0
#     if idx == 9
#         if sig == "SK"
#             arr = arr.map{|d| d = 10 if d=="X"} if arr.include?("X")
#             score = arr[0] + arr[1] + arr.sum
#         elsif sig == "SP"
#             arr = arr.map{|d| d = 10 if d=="X"} if arr.include?("X")
#             score = arr.sum + arr[0]
#         else 
#             arr = arr.map{|d| d = 10 if d=="X"} if arr.include?("X")
#             score = arr.sum
#         end
#     elsif idx != 0
#         if sig == "SK"
#             arr[0] = 10 if arr[0] == "X"
#             score = arr.sum * 2
#         elsif sig == "SP"
#             arr[0] = 10 if arr[0] == "X"
#             score = arr.sum + arr[0]
#         else 
#             arr[0] = 10 if arr[0] == "X"
#             score = arr.sum
#         end
#     elsif arr[0] == "X"
#         score = 10
#     else
#         score = arr.sum
#     end
#     score
# end




# if x.length == 10
    # sign = nil
    # score = 0
    # frames.each_with_index do |n,idx|
    #     if n[0] == "X"
    #         score = cal_score(n,sign,idx)
    #         puts score
    #         total += score
    #         sign = "SK"
    #     elsif n.sum == 10
    #         score = cal_score(n,sign,idx)
    #         puts score
    #         total += score
    #         sign = "SP"
    #     else
    #         score = cal_score(n,sign,idx)
    #         puts score
    #         total += score
    #         sign = nil
    #     end
    #     binding.debugger
    # end
    # p total

score = 0
frames.each_with_index do |n,idx|
	if idx < 9
    if n[0] == 10
			if frames[idx+1][0] == 10
				score = 10 + 10 + ( frames[idx+1][1] || frames[idx+2][0])
			else
				score = 10 + frames[idx+1][0]+frames[idx+1][1]
			end
      total += score
    elsif n.sum == 10
      score = 10 + frames[idx+1][0]
      total += score
    else
      score = n.sum
      total += score 
    end
	else 
		score = n.sum
		total += score
  end
end
p total


#spair or strike

# def score_sign(arr, sig)
#     arr.each_with_index do |n,idx|
#         if n[0] == "X"
#             sig = "SK"
        

#         elsif n.sum == 10
#             sig = "sp"

#         else
            
            
#         end
#     end
# end



        