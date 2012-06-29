class Number
  def initialize
    @content = []
  end

  def to_s
    @content.each do |i|
     s = i.join(' ')
     puts s
    end
  end
end

class Numbers
  def initialize
    @coll = [] 
  end

  def add(n)
    @coll << n
  end

  def to_s
    @coll.each { |i| puts i }
  end
end

# a concrete number is an array of arrays 
# display representation data

class One < Number
  def initialize
    super
    5.times { @content << ['o', '|', 'o'] }
  end
end

class Two < Number
  def initialize
    super
    @content << ['-', '-', '-']
    @content << ['o', 'o', '|']
    @content << ['-', '-', '-']
    @content << ['|', 'o', 'o']
    @content << ['-', '-', '-']
  end
end

class Three < Number
  def initialize
    super
    @content << ['-', '-', '-']
    @content << ['o', 'o', '|']
    @content << ['-', '-', '-']
    @content << ['o', 'o', '|']
    @content << ['-', '-', '-']
  end
end
