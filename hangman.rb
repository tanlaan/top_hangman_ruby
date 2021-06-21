require_relative './lib/hangmen.rb'

def read_words_from_file()
    words = File.open('./5desk.txt', 'r')
    word_list = []
    words.each_line do |word|
        word_list += [word.downcase] if word.length >= 5 && word.length <= 12
    end
    word_list
end

puts read_words.count
puts hangmen(6)