require_relative './lib/hangmen.rb'

def read_words_from_file()
    words = File.open('./5desk.txt', 'r')
    word_list = []
    words.each_line do |word|
        word_list += [word.downcase] if word.length >= 5 && word.length <= 12
    end
    word_list
end

def get_random_word(words)
    words[Random.rand(words.length)]
end

def start_message()
    puts "Let's play a game of hangman!"
    puts "Try and guess the word before our little guy gets hung."
end

def play_again
    player_response = nil
    while valid_response(player_response).nil?
        puts "Want to play again?"
        print ">"
        player_response = gets.chomp
    end
    valid_response(player_response)
end

def valid_response(response)
    valid_yes = ['yes','y']
    valid_no = ['no', 'n']
    return true if valid_yes.include?(response)
    return false if valid_no.include?(response)
    nil
end

def game(words)
    game_over = false
    word = get_random_word(words)
    count = 0
    hanged_man = 6
    reveal_word = "_ " * word.length
    failed_guesses = []
    until game_over
        puts hangmen(count)
        puts reveal_word
        game_over = true
    end
end

def main()
    words = read_words_from_file
    quit = false
    until quit
        game(words)
        quit = !play_again
    end
end

main