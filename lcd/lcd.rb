require './numbers.rb'

class LCD
  def initialize ( input, scale = 2)
    puts "initializing LCD ..."
    puts "scale is #{scale}"
    puts "input is #{input}"

    # hash of input values to class names
    num_hash = { "1" => :one,
                 "2" => :two,
                 "3" => :three }

    # collection of numbers - will hold corresponding
    # input values
    @nums = Numbers.new

    # set scale
    @scale = scale

    # convert input to array
    input_arr = input.to_s.split('')

    # load collection
    input_arr.each do |i| 
      @nums.add Module.const_get(num_hash[i].to_s.capitalize).new
    end
  end
  
  def print
    @nums.print(@scale)
  end
end


until ARGV.empty? do
  temp = ARGV.shift
  scale = ARGV.shift.to_i if temp == "-s"
  input = scale ? ARGV.shift : temp
end

scale = scale ||= 2

lcd = LCD.new(input, scale)
lcd.print
