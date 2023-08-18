Colors = ['r','b','g','y','v','w']
@possible_solution = Colors.repeated_permutation(4).to_a
@possible_solution.map! {|code|  code.join('')}

def get_random_code
    code = Colors.sample(4).join
end

def get_guess
    while 1
        puts "Enter your Guess"
        guess = gets.chomp
        if (guess.length == 4 and (guess.split("")).all?{ |char| Colors.include? char})
            break
        end
    end
    guess
end

def check_white(code, guess)
    whitepeg = 0
    guess.split('').each{ |i|
        if code.split('').include?(i)
            whitepeg += 1
        end
    }
    whitepeg -= check_black(code, guess)
    whitepeg
end

def check_black(code, guess)
    blackpeg = 0
    (0..3).each{ |i|
        if code[i] == guess[i]
            blackpeg += 1
        end
    }
    blackpeg 
end

def round_codeguesser
    code = get_random_code
    guess = get_guess
    score = 1
    until(code == guess)
        if score == 12
            puts "The Codemaker Won!"
            break
        end
        puts "Round #{score}"
        puts "Correct Color but wrong Position :#{check_white(code, guess)}"
        puts "Correct Color with Correct Positon :#{check_black(code, guess)}"
        guess = get_guess
        score += 1
    end
    puts 'Correct Guess! Code has been Cracked!'
    puts "Code Maker Scored #{score}"
end

def choice
    puts "Want to play as a Codemaker or CodeGuesser"
    while 1
        choice = gets
        if choice.downcase.rstrip == 'codemaker'
            puts 'You chose to play as codemaker'
            return 0
        elsif choice.downcase.rstrip == 'codeguesser'
            puts 'You chose to play as codeguesser'
            return 1
        else
            puts "Invalid Choice"
        end
    end
end

def round_codemaker
    code = get_guess
    @computer_guess = 'rgby'
    puts "Computer guessed #{@computer_guess}"
    score = 1
    until(code == @computer_guess)
        if score == 12
            puts "The Codemaker Won!"
            break
        end
        puts "Round #{score}"
        puts "Correct Color but wrong Position :#{check_white(code, @computer_guess)}"
        puts "Correct Color with Correct Positon :#{check_black(code, @computer_guess)}"
        get_computer_guess(check_white(code, @computer_guess),check_black(code, @computer_guess))
        @computer_guess = @possible_solution[0]
        puts "Computer guessed #{@computer_guess}"
        score += 1
    end
    puts 'Correct Guess! Code has been Cracked!'
    puts "Code Maker Scored #{score}"
end


def play
    if choice == 0
        round_codemaker
    else 
        round_codeguesser
    end
end

def get_computer_guess(white,black)
    @possible_solution.delete_if { |code| check_black(code,@computer_guess) != black || check_white(code ,@computer_guess) != white }
    sleep(3)
end
play