class Encrypter

  def initialize( keystream )
    @keystream = keystream
  end

  def sanitze( s )
    s = s.upcase
    s = s.gsub(/[^A-Z]/, '')
    s = s + 'X' * ((5 - s.size % 5) % 5)
    out = ''
    (s.length / 5).times {|i| out << s[i*5, 5] << ' '}
    return out.strip!
  end

  def mod( n )
    return n - 26 if n > 26  
    return n + 26 if n < 1
    return n    
  end

  def process( s , &block )
    s = sanitze(s)
    out = ''
    s.each_byte do |c|
      if c >= ?A.ord and c <= ?Z.ord 
        key = @keystream.get
        res = block.call(c, key)
        out << res.chr 
        puts out
      else
        out << c.chr
      end
    end 
    return out 
  end

  def encrypt( s )
    return process(s) { |c, key| 64 + mod( c + key.ord - 128 ) }
  end

  def decrypt( s )
    return process(s) { |c, key| 64 + mod( c - key.ord ) }
  end

end


class Deck

  def initialize
    @deck = (1..52).to_a << :A << :B 
  end

  def number ( index )
    return 53 if @deck[index] == :A or @deck[index] == :B
    return @deck[index]
  end

  def top_joker
    return @deck.index(:A) < @deck.index(:B) ? @deck.index(:A) : @deck.index(:B)
  end

  def bottom_joker
    return @deck.index(:A) < @deck.index(:B) ? @deck.index(:B) : @deck.index(:A)
  end

  def move_a
    move_down @deck.index(:A)
  end

  def move_b
    2.times { move_down @deck.index(:B) }
  end

  def move_down( index )
    temp = @deck[index]
    neighbor = @deck[ (index + 1) % 54 ]
    @deck[index] = neighbor
    @deck[ (index + 1) % 54 ] = temp
  end

  def triple_cut
    first_cut_index = top_joker > 0 ? top_joker - 1 : 0
    first_cut = first_cut_index > 0 ? @deck[0..first_cut_index] : []
    second_cut = @deck[top_joker, bottom_joker - top_joker + 1]
    third_cut = @deck[bottom_joker + 1,@deck.length - bottom_joker + 1]
    @deck = third_cut + second_cut + first_cut
    puts "first cut: #{first_cut}"
    puts "second cut: #{second_cut}"
    puts "third cut: #{third_cut}" 
  end
  
  def update
    puts @deck.join
    move_a
    puts @deck.join
    move_b
    puts @deck.join
    triple_cut
    puts @deck.join
  end

  def get
    update
    return 67
  end

end


msg = "Code in ruby, live longer!"
puts msg
e = Encrypter.new( Deck.new )
enc = e.encrypt( msg )
puts enc
