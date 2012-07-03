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
    @numerals = {
      'I' => 1,
      'V' => 5,
      'X' => 10,
      'L' => 50,
      'C' => 100,
      'D' => 500,
      'M' => 1000
    }

    convert(v)
  end

  # converts an integer to a roman numeral, or
  # if parameter is a roman numeral, converts to integer
  def convert( v )
    if v.kind_of?(String) 
      @numeral = v 
      @number = numberify(v)
    else
      @numeral = romanify(v) 
      @number = v
    end
  end

  # given a numeric value n , return next highest roman numeral in hash
  def upper(n)
    curr = @numerals.invert[n]
    curr #@numerals.keys[curr].next
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
   roman += get(floor) * repeater 
   # store REMAINDER = ORIG - FLOOR                                          # => '4' 
   remainder = orig - ( floor * repeater )
   # if REMAINDER, append romanify(remainder)                                # => 'VIIII'
   if remainder > 0
    roman += romanify(remainder)
   end
   # if character repeats more than three times in ROMAN
   if repeats(roman)
     # store next_num(FLOOR) in NEXT_NUM                                       # => 'X'
     upper_numeral = upper(floor) 
     # store next_val(FLOOR) in NEXT_VAL                                       # => '10'  
     upper_val = @numerals[upper_numeral]
     # store SUBTR as NEXT_VAL - ORIG                                          # => '1'
     subtr = upper_val - orig
     # ROMAN += romanify(SUBTR) + NEXT_VAL                                     # => 'IX'
     roman = upper_numeral #romanify(subtr) + upper
   end
   roman
  end


  def numberify(n)
  end

  def repeats(s)
    s = s.gsub(/[^A-Za-z]/, '')
    # TODO - find a better way to check for three of the same chars in a row
    last = '', counter = 0
    s.split('').each do |c|
      counter = ( last == c ) ?
                counter + 1 :
                0
      return true if counter == 3 
      last = c
    end
    return false
  end

  # given a numeric value n, return the corresponding roman numeral in hash
  def get(n)
    @numerals.invert[n] 
  end
end

# OUTPUT
r = Roman.new(9)
puts "9 converts to #{r.numeral}"
#puts "III converts to #{r.convert('III')}"


