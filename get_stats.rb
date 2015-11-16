require './parser'

unless (1..3).include?(ARGV.size)
  puts 'Wrong number of command line arguments'
  exit 1
end

parser = if ARGV.size > 1
  args = ARGV[0..-2]
  Parser.new args.flatten
else
  Parser.new
end

puts parser.stats_for_user(ARGV.last.to_i)
