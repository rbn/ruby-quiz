require './numbers.rb'

class LCD
  def initialize
    @one = One.new
    @two = Two.new
    @three = Three.new
    
    @nums = Numbers.new
    @nums.add @one
    @nums.add @two
    @nums.add @three 
    
    puts @nums
  end
end

puts LCD.new

