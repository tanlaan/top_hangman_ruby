# Textual User Interface functions
def play_again_prompt
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

def get_user_guess(guesses)
    loop do
        print '>'
        guess = gets.chomp
        return guess if guess.length == 1
        return 'save' if guess.downcase == 'save'
    end
end