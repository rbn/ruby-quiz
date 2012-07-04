class Roman
  attr_accessor :numerals

  def initialize( v )
    # define hash of roman numerals and their numeric equivalents
    @numerals = {
      'I' => 1,
      'V' => 5,
      'X' => 10,
      'L' => 50,
      'C' => 100,
      'D' => 500,
      'M' => 1000
    }
  
    # base ten numbers that start with a 4 or 9 require numeral subtraction
    @subtractors = [ 4, 9 ] 

    # assign values to variables based on input type
    if v.kind_of?(String) 
      puts 'numeral to int not implemented!'
    else
      @numeral = convert_to_roman(v) 
      @number = v
    end
  end

  def numeral
    @numeral 
  end

  def number
    @number
  end

  private

  # convert an integer to a roman numeral 
  def convert_to_roman(n)
    roman = ''
    # convert to string and reverse order
    s = n.to_s.split('').reverse                         # => '[ 3, 9, 4, 1 ]'
    # iterate  
    s.each_with_index do | value, index |           
      # convert back to number
      number = value.to_i
      # calculate power
      power = index
      # multiply number by a calculated factor of 10 
      factor = number * ( 10 ** power )     # => 3, 90, 400, 1000    
      # translate power 10 number
      power_ten_numeral = translate_power_ten( factor )  
      # prepend to roman numeral string
      roman.insert( 0, power_ten_numeral )
    end
    roman
  end

  # given a number raised to the power of 10, return the corresponding numeral
  def translate_power_ten(n)
    # determine if subtraction is necessary by looking at left-most digit
    left = n.to_s[0,1].to_i
    return translate_by_subtraction(n) if @subtractors.include?(left) 
                                                                   
    # init vars
    roman = ''                                                                # => 9
    lower_numeric = @numerals[lower(n)] 
    lower_numeral = lower(n)

    # calculate repeater value                                                # => 1 
    repeats = n / lower_numeric

    # repeat numeral as necessary                                             # => 'V'
    roman += lower_numeral * repeats
    
    # calculate remainder                                                     # => '2' 
    remainder = n - ( lower_numeric * repeats )
    
    # if REMAINDER, append romanify(remainder)                                # => 'VII'
    roman += tranlsate(remainder) if remainder > 0
    
    roman
  end

  # perform roman numeral subtraction
  def translate_by_subtraction(n)
    return subtractor(n) + upper(n)
  end

  # given an int, return the corresponding upper-bounding numeral
  def upper(n)
    upper = n > @numerals[mid(n)] ? 
              10 * ( 10 ** power(n) ) :
              5 * ( 10 ** power(n) )
    return @numerals.invert[upper]
  end

  # given an int, return the closest middle numeral
  def mid(n)
    return @numerals.invert[ 5 * ( 10 ** power(n) )]
  end

  # given an int, return the corresponding lower-bound numeral
  def lower(n)
    lower = n < @numerals[mid(n)] ? 
              1 * ( 10 ** power(n) ) :
              5 * ( 10 ** power(n) )
    return @numerals.invert[lower]
  end

  # given an int, return the numeral required for subtraction in its power-10 interval
  def subtractor(n)
    return @numerals.invert[ 1 * ( 10 ** power(n) ) ]
  end

  # given an int, returns the power used in raise-to-power-10 calculations
  def power(n)
    n.to_s.length - 1
  end
end

# OUTPUT
r = Roman.new(309)
puts "#{r.number} converts to #{r.numeral}"
r = Roman.new('VII')
puts "VII converts to #{r.number}"

