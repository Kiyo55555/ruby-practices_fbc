
#ARGVのinputをバリデートする必要がある,

#.だけのパターン
#/.のパターン
#/./~~/~~のパターン もしなければエラーを出す
#../~~/~のパターン

file_path = ARGV


Dir.glob(file_path) { |dir_file|
  index = dir_file.reverse.index(%r{/})
  file_name = dir_file.slice(index..-1)
  
  puts file_name
  
}



