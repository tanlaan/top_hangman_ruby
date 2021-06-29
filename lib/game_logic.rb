require_relative './tui.rb'
require_relative './saving.rb'
require 'yaml'

class Game
    attr_reader :word, :count, :reveal, :guesses, :failed_guesses
    def initialize(words)
        @game_over = false
        @word = get_random_word(words)
        @count = 0
        @hanged_man = 6
        @reveal =  "_" * @word.length
        @guesses = []
        @failed_guesses = []
        @save_file_path = 'hangman.yaml'
        @saved = File.exist?(@save_file_path)
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

    def correct_guess_insert(guess)
        @word.split('').each_with_index do |character, index|
            @reveal[index] = character if character == guess   
        end
    end

    def start

        # If we have a save, do we want to continue?
        continue = get_user_continue if @saved

        if continue
            self.import(YAML.load_file(@save_file_path))
        else
            File.delete(@save_file_path) if File.exist?(@save_file_path)
        end
        @saved = false

        until @game_over
            print_board

            # Get user input and verify against prior guesses
            guess = get_user_guess(@guesses)

            # Save and exit
            if guess == 'save'
                write_to_file(YAML.dump(self), @save_file_path)
                @saved = true
                @game_over = true
                next
            end
            
            # Add to guesses
            @guesses += [guess]

            # Add to failed_guesses if not in word
            @failed_guesses += [guess] unless @word.split('').include?(guess)

            # Modify reveal_word based on guess
            correct_guess_insert(guess) if @word.split('').include?(guess)
            if @reveal == @word
                print_board
                puts 'You Win!'
                @game_over = true 
            end

            # Increment our count if we failed to guess a character
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

def import(state)
    @word = state.word
    @count = state.count
    @reveal = state.reveal
    @guesses = state.guesses
    @failed_guesses = state.failed_guesses
end