class Number
  @@height = 5 
  
  def self.height
    return @@height
  end
  
  def self.height=(n)
   @@height = n 
  end

  def initialize 
    @content = []
    @sep = ''
  end

  def scale(n)
    @content.each do |row|
      #puts "scale to #{n}"
    end
  end
  
  def print (row_index = nil)
    return @content[row_index.to_i].join(@sep) if row_index 
    s = ''
    @content.each do |arr| 
      s += arr.join(@sep) + "\n"
    end
    return s
  end
end

class Numbers
  def initialize
    @coll = [] 
  end

  def add(n)
    @coll << n
  end

  def print( scale = 1 ) 
    2.times { puts } 

    Number.height.times do |i|
      row = ''
      @coll.each do |num|
        temp = num.print(i)
        # scale horizontally
        temp[1,1] = temp[1,1] * scale 
        temp += '   '
        row += temp
      end
      
      # scale vertically
      if row =~ /\|/
        scale.times { puts row }
      else
        puts row
      end
    end

    2.times { puts }
  end
end

# a concrete number is an array of arrays 
# display representation data

class One < Number
  def initialize
    super 
    @content << [' ', ' ', ' '] 
    @content << [' ', ' ', '|'] 
    @content << [' ', ' ', ' '] 
    @content << [' ', ' ', '|'] 
    @content << [' ', ' ', ' '] 
  end
end

class Two < Number
  def initialize
    super
    @content << [' ', '-', ' ']
    @content << [' ', ' ', '|']
    @content << [' ', '-', ' ']
    @content << ['|', ' ', ' ']
    @content << [' ', '-', ' ']
  end
end

class Three < Number
  def initialize
    super
    @content << [' ', '-', ' ']
    @content << [' ', ' ', '|']
    @content << [' ', '-', ' ']
    @content << [' ', ' ', '|']
    @content << [' ', '-', ' ']
  end
end
