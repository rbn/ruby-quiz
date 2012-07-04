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
   
  def convert_to_roman(n)
    roman = ''
    s = n.to_s                                # => '1493'
    s = s.split('').reverse                   # => '[ 3, 9, 4, 1 ]'
    s.each_with_index do | value, index |      # => 3, 90, 400, 1000
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
             create(n)
  end

  # perform roman numeral subtraction
  def subtract(n)
    s = n.to_s
    power = s.length - 1
    mid = 5 * ( 10 ** power )
    return n > mid ?
             lower(n) + upper(n) :
             lower(n) + mid(n)
  end

  # creates a roman numeral that does not require subtraction
  def create(n)
   # store original                                                          # => 7 
   s = n.to_s 
   
   # init numeral                                                            # => ''
   roman = ''
   
   # calculate multiplier                                                    # => 1
   mult = 10 ** (s.length - 1)
   
   # calculate floor value (numeric value of closest lower-bound numeral)    # => 5
   floor = n >= ( 5 * mult ) ? 
             ( 5 * mult )  : 
             mult
   
   # calculate repeater value                                                # => 1 
   repeater = n / floor
   
   # get roman numeral and repeat as necessary                               # => 'V'
   roman += @numerals.invert[floor] * repeater 
   
   # calculate remainder                                                     # => '2' 
   remainder = n - ( floor * repeater )
   
   # if REMAINDER, append romanify(remainder)                                # => 'VII'
   roman += romanify(remainder) if remainder > 0
   
   roman
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

end

# OUTPUT
r = Roman.new(3393)
puts "#{r.number} converts to #{r.numeral}"
r = Roman.new('VII')
puts "VII converts to #{r.number}"

