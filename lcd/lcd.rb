require './numbers.rb'

class LCD
  def initialize ( input )
    # hash of input values to class names
    num_hash = { "1" => :one,
                 "2" => :two,
                 "3" => :three }

    # collection of numbers - will hold corresponding
    # input values
    @nums = Numbers.new

    # convert input to array
    input_arr = input.to_s.split('')

    # load collection
    input_arr.each do |i| 
      @nums.add Module.const_get(num_hash[i].to_s.capitalize).new
    end
  end
  
  def print( scale = 1 )
    @nums.print(scale)
  end
end

if ARGV.empty?
  puts "please enter command line arguments!"
  exit
end

until ARGV.empty? do
  temp = ARGV.shift
  scale = ARGV.shift.to_i if temp == "-s"
  input = scale ? ARGV.shift : temp
end

scale = scale ||= 2

lcd = LCD.new(input)
lcd.print(scale)
