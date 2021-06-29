require_relative './tui.rb'
require_relative './saving.rb'
require 'json'

class Game
    def initialize(words)
        @game_over = false
        @word = get_random_word(words)
        @count = 0
        @hanged_man = 6
        @reveal =  "_" * @word.length
        @guesses = []
        @failed_guesses = []
        @saved
    end

    def get_random_word(words)
        words[Random.rand(words.length)]
    end

    def print_reveal
        puts @reveal.split('').join(' ')
    end

    def print_hangman
        puts hangmen(@count)
    end
    
    def print_failed_guesses
        puts "Bad Guesses: #{@failed_guesses.join(', ')}" if @failed_guesses.length > 0
    end

    def print_board
        print_hangman
        print_reveal
        print_failed_guesses
    end

    def get_user_guess(guesses)
        loop do
            print '>'
            guess = gets.chomp
            return guess if guess.length == 1
            return 'save' if guess.downcase == 'save'
        end
    end

    def correct_guess_insert(guess)
        @word.split('').each_with_index do |character, index|
            @reveal[index] = character if character == guess   
        end
    end

    def start
        until @game_over
            print_board

            # Get user input and verify against prior guesses
            guess = get_user_guess(@guesses)

            # Save and exit
            if guess == 'save'
                write_to_file(self.to_json, './save/hangman.json')
                @saved = true
                @game_over = true
                next
            end
            
            # Add to guesses
            @guesses += [guess]
            # Add to guesses if not in word
            @failed_guesses += [guess] unless @word.split('').include?(guess)
            # Modify reveal_word based on guess
            correct_guess_insert(guess) if @word.split('').include?(guess)
            if @reveal == @word
                print_board
                puts 'You Win!'
                @game_over = true 
            end

            @count += 1 unless @word.split('').include?(guess)

            if @count == @hanged_man
                print_board
                puts 'You lost!'
                puts "The word was #{@word}!"
                @game_over = true
            end
        end
        @saved
    end
end
