# frozen_string_literal: true

param = ARGV.map { |n| n.split(',') }
score_array = param[0]

fix_strike = []
score_array.each do |score|
  if score == 'X'
    fix_strike << 10
    fix_strike << 0 if fix_strike.length < 18 # 10フレーム目はストライクでも3投できるため、0は追加しない。
  else
    fix_strike << score.to_i
  end
end

# 二次元配列に収める
frames = []
fix_strike.each_slice(2) do |frame|
  if frames.length <= 9
    frames << frame
  else
    frames[9] << frame[0]
  end
end

total = 0
extra_score = 0
frames.each_with_index do |frame, i|
  total += frame.sum
  next if frame.sum != 10 || i >= 9

  extra_score = if frame[0] == 10                    # ストライクの場合
                  if frames[i + 1][0] == 10          # 次もストライクだったら、２つ先までのフレームを参照するため
                    if i != 8
                      10 + frames[i + 2][0]
                    else
                      10 + frames[i + 1][1]
                    end
                  else
                    frames[i + 1][0] + frames[i + 1][1] # sumは9フレーム目の場合に３投分加算されるので使わない
                  end
                else                                 # スペアの場合
                  frames[i + 1][0]
                end
  total += extra_score
end
p total
