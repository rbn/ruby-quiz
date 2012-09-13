class Whiteout
  def self.Whiten( filename )
    File.open(filename, 'r') do |file|
      file.each_line do |line|
        puts "::: " + line
      end
    end
  end
end

if __FILE__ == $0
  puts "running from the command line"
  ARGV.each do |filename|
    # open files
    # white it out
    # execute the file 
    Whiteout.Whiten(filename)
  end
else
  puts "not running from the command line"
end
