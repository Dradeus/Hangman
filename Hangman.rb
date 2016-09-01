require "io/console"

puts "Welcome to Hangman!\n"
puts "Selecting a word between 5 and 12 characters to start the game..."

dictionary = File.readlines "5desk.txt"
valid_words = ""
valid_words = dictionary.select{ |w| str = w.size; str >= 5 && str <=  12}

gameover = false
new_game = false

def check_word(input,word,show)
    idx = 0
		counter = 0
		w = word.scan /\w/
   	
		w.each do |check|
			
			if check == input
				show[idx] = input
				counter += 1
			end
			
			idx += 1
		end
		
		if counter >= 1
			return true
		else
		 return false
		end  
end

def win_condition(word,show)
    ray_compare = word.scan /\w/
    idx = 0
    counter = 0
    ray_compare.each do |check|
        if check == show[idx]
            counter += 1
        end
        idx +=1
    end

    if counter == ray_compare.size
        return true
    else
        return false
    end
end

def display(show)
    show.each do |contents|
        print contents
    end
    puts
end

while !gameover
    
    word = valid_words[rand(0..valid_words.size-1)]
    puts "the word has been chosen"
    puts "start guessing now!"
    show = Array.new( word.size-1, " _ " )
    w = word.scan /\w/    
    
    display(show)
	puts
    
    while !new_game
        
        input = STDIN.getch
        if check_word(input,word,show) 

            display(show)
			
            if win_condition(word,show)
                puts "you did it!"
                new_game = true 
            end
        
        else
            puts "#{input} is not a part of the word"
        end
    
    end

    gameover = true

end