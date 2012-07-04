# 
# 1  = I
# 2  = II
# 3  = III
# 4  = IV
# 5  = V
# 6  = VI
# 7  = VII
# 8  = VIII
# 9  = IX
# 10 = X
#

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

    # convert input to roman numeral
    convert(v)
  end

  # converts an integer to a roman numeral, or
  # if parameter is a roman numeral, converts to integer
  def convert( v )
    if v.kind_of?(String) 
      @numeral = v 
      @number = numberify(v)
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
   
  def romanify(i)
   # store original number as ORIG                                           # => 9
   orig = i
   
   # store roman numeral as ROMAN (initialize as empty string)               # => ''
   roman = ''
   
   # store multiplier as MULT = 10**( (no. columns right of 0) - 1 )         # => 1
   mult = 10**(i.to_s.length - 1)
   
   # store current floor as FLOOR = ORIG >= 5 * MULT ? 5 * MULT : MULT       # => 5
   floor = orig >= ( 5 * mult ) ? 
                     ( 5 * mult )  : 
                     mult
   
   # repeater = ORIG / FLOOR                                                 # => 1 
   repeater = orig / floor
   
   # ROMAN += @numerals.invert[FLOOR]                                        # => 'V'
   roman += @numerals.invert[floor] * repeater 
   
   # store REMAINDER = ORIG - FLOOR                                          # => '4' 
   remainder = orig - ( floor * repeater )
   
   # if REMAINDER, append romanify(remainder)                                # => 'VIIII'
   if remainder > 0
    roman += romanify(remainder)
   end
   
   roman
  end

  def convert_to_roman(n)
    roman = ''
    s = n.to_s                                # => '1493'
    s = s.split('').reverse                   # => '[ 3, 9, 4, 1 ]'
    s.each_with_index do | value, index |
      power = index
      base_ten = ( value.to_i * ( 10 ** power ) ).to_s  
      roman.insert( 0, get_base_ten_numeral( base_ten ) )
    end
    roman
  end

  # given a number base 10, return the corresponding numeral
  def get_base_ten_numeral(s)
    n = s.to_i
    # examine left most character
    left = s[0,1]
    # if 4 or 9, subtract from upper bound 
    return @subtractors.include?(left.to_i) ?
             subtract(n) : 
             romanify(n)
  end

  def upper(n)
    s = n.to_s
    power = s.length - 1
    upper = 10 * ( 10 ** power )
    return @numerals.invert[upper]
  end

  def mid(n)
    s = n.to_s
    power = s.length - 1
    mid = 5 * ( 10 ** power )
    return @numerals.invert[mid]
  end

  def lower(n)
    s = n.to_s
    power = s.length - 1
    lower = 1 * ( 10 ** power )
    return @numerals.invert[lower]
  end

  def subtract(n)
    s = n.to_s
    power = s.length - 1
    mid = 5 * ( 10 ** power )
    return n > mid ?
             lower(n) + upper(n) :
             lower(n) + mid(n)
  end
end

# OUTPUT
r = Roman.new(1493)
puts "1493 converts to #{r.numeral}"


