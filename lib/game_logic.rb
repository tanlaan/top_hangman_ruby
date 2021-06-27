class Game
    def initialize(words)
        @game_over = false
        @word = get_random_word(words)
        @count = 0
        @hanged_man = 6
        @guess =  "_" * @word.length
        @failed_guesses = []
    end

    def get_random_word(words)
        words[Random.rand(words.length)]
    end

    def reveal(guess)
        guess.split('').join(' ')
    end

    def print_board
        puts hangmen(@count)
        puts reveal(@guess)
    end

    def start
        until @game_over
            print_board

            # Take input
            # Modify reveal_word based on input

            if @reveal_word == @word
                print_board
                puts 'You Win!'
                @game_over = true 
            end

            @count += 1

            if @count == @hanged_man
                print_board
                puts 'You lost!'
                @game_over = true
            end
        end
    end
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