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

  def process( s , &block )
    s = sanitze(s)
    out = ''
    s.each_byte do |c|
      if c >= ?A.ord and c <= ?Z.ord 
        key = @keystream.get
        res = block.call(c, key[0])
        out << res.chr 
      else
        out << c.chr
      end
    end 
    return out 
  end

  def encrypt( s )
    return process(s) { |c, key| c  + 1 }
  end

  def decrypt( msg )
    return process(s) { |c, key| c - 1 }
  end

end


class Deck

  def initialize
    @deck = (1..52).to_a << 'A' << 'B'
  end

  def move_a

  end

  def move_b

  end

  def move_down

  end

  def triple_cut
  
  end
  
  def update
    #do work
  end

  def get
    return 'a'
  end

end


msg = "Code in ruby, live longer!"
e = Encrypter.new( Deck.new )
enc = e.encrypt( msg )
puts enc
