class Mastermind
  def initialize
    @codemaker_array = []
    @codebreaker_array = []
    @colours = ["red", "yellow", "green", "blue", "black", "white"]
    @players = []
  end

  def setup_game
    until @codemaker_array.length == 4
      @codemaker_array << @colours[pick_colours()]
    end
    start()
  end

  def pick_colours
    idx = rand(0..5)
  end

  def start
    number_of_turns = 0
    codemaker_points = 0
    previous_array = []
    p @codemaker_array
    until number_of_turns == 12
      output = []
      codemaker_points += 1
      
      print "Previous guess: "
      p previous_array
      play()

      if @codebreaker_array == @codemaker_array
        break
      end
      
      check_arrays(output)
   
      previous_array = @codebreaker_array
      @codebreaker_array = []

      print "Clue: "
      puts output.shuffle().to_s.gsub(", "," | ").sub("]","").sub("[","").gsub("\"","")
      number_of_turns += 1
    end 
    
    check_win(number_of_turns, codemaker_points)    
  end

  def check_win(number_of_turns, codemaker_points)
    if number_of_turns < 12
      puts "You have broken the code!"
    else
      puts "You have failed to break the code!"
      codemaker_points += 1
    end
    puts "Codemaker points: #{codemaker_points}"
  end

  def check_arrays(output)
    #Find way to make sure that a colour that is in right position is not evaluated twice for the second conditional
    @codemaker_array.each_with_index do |element, idx|
      if element.eql?(@codebreaker_array[idx])
        output << "*"
      elsif @codemaker_array.include?(@codebreaker_array[idx] && checked_values)
        output << "-"
      else
        output << " "
      end
    end
  end

  def play
    for i in 0..3
      print "Index: #{i}, "
      print "Colour: "
      colour = gets.chomp.downcase
      @codebreaker_array[i] = colour
    end
  end
end

game = Mastermind.new
game.setup_game