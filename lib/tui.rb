# Textual User Interface functions
def user_prompt(phrase)
    player_response = nil
    while valid_response(player_response).nil?
        puts phrase
        print ">"
        player_response = gets.chomp
    end
    valid_response(player_response)
end

def play_again_prompt
    user_prompt("Want to play again?")
end

def valid_response(response)
    valid_yes = ['yes','y']
    valid_no = ['no', 'n']
    return true if valid_yes.include?(response)
    return false if valid_no.include?(response)
    nil
end

def get_user_guess(guesses)
    loop do
        print '>'
        guess = gets.chomp
        return guess if guess.length == 1 && !guesses.include?(guess)
        return 'save' if guess.downcase == 'save'
        puts 'Try a different character...'
    end
end

def get_user_continue
    user_prompt('Continue your saved game?')
end