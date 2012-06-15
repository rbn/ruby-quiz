class Encrypter

  def initialize( keystream )
    @keystream = keystream
  end

  def sanitize( s )
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
    s = sanitize(s)
    out = ''
    s.each_byte do |c|
      if c >= ?A.ord and c <= ?Z.ord 
        key = @keystream.get
        res = block.call(c, key)
        out << res.chr 
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

  def number ( card )
    return 53 if card == :A or card == :B
    return card 
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
    neighbor_index = (index + 1) % 54
    if neighbor_index == 0 
      @deck = @deck[0,1] + @deck[@deck.length-1, 1] + @deck[1, @deck.length - 2]
      return
    end
    neighbor = @deck[ (index + 1) % 54 ]
    @deck[index] = neighbor
    @deck[ (index + 1) % 54 ] = temp
  end

  def triple_cut
    do_first = top_joker > 0 ? true : false 
    first_cut = do_first ? 
                  @deck[0, top_joker] : 
                  []
    second_cut = @deck[top_joker, bottom_joker - top_joker + 1]
    do_third = bottom_joker < @deck.length - 1 ? true : false
    third_cut = do_third ? 
                  @deck[bottom_joker + 1, @deck.length - bottom_joker + 1] :
                  []
    #puts
    #puts "first cut: #{first_cut}"
    #puts "second cut: #{second_cut}"
    #puts "third cut: #{third_cut}" 
    #puts
 
    @deck = third_cut + second_cut + first_cut
  end
  
  def count_cut
    cut_to = last = number( @deck.last )
    return if cut_to == 53
    top_cut = @deck[0, cut_to] 
    in_between_cut = @deck[cut_to, @deck.length - cut_to - 1] 
    bottom = @deck[-1,1]
    @deck = in_between_cut + top_cut + bottom 
  end

  def output
    ret = number( @deck[ number ( @deck[0] ) ] )
    return if ret == 53
    return 64 + ( number ( @deck[ number( @deck[0] ) ] ) % 26 )
  end
 
  def update
    #puts "before update: " + @deck.join(',')
    move_a
    #puts "a moved:       " + @deck.join(',')
    move_b
    #puts "b moved:       " + @deck.join(',')
    triple_cut
    #puts "triple-cutted: " + @deck.join(',')
    count_cut
    #puts "count-cutted:  " + @deck.join(',')
    #2.times { puts } 
  end

  def get
    update
    return output if output 
    get
  end

end


msg = "Code in ruby, live longer!"
puts msg
e = Encrypter.new( Deck.new )
enc = e.encrypt( msg )
puts "encr: " + enc

e_prime = Encrypter.new( Deck.new )
puts "decr: " + e_prime.decrypt( enc )

rq_msgs = [ "CLEPK HHNIY CFPWH FDFEH", "ABVAW LWZSY OORYK DUPVH" ] 

rq_msgs.each do |m|
  puts "encoded message : " + m 
  e_prime = Encrypter.new( Deck.new )
  puts "decoded message : " + e_prime.decrypt( m ) 
end
