require_relative './lib/hangmen.rb'
require_relative './lib/game_logic.rb'

def read_words_from_file()
    words = File.open('./5desk.txt', 'r')
    word_list = []
    words.each_line do |word|
        word_list += [word.downcase] if word.length >= 5 && word.length <= 12
    end
    word_list
end

def start_message()
    puts "Let's play a game of hangman!"
    puts "Try and guess the word before our little guy gets hung."
end

def main()
    puts 'Loading...'
    words = read_words_from_file
    playing = true
    start_message
    while playing
        Game.new(words).start
        playing = play_again
    end
end

main