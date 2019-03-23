#!/usr/bin/ruby
raise 'Pass path as argument' if ARGV.empty?

puts 'Find the teams who had won more games'
starting = Time.now
path = ARGV[0]
pattern = /^(?<date>\d{4}\-\d{2}\-\d{2})\,(?<team1>.+?)\,(?<team2>.+?)\,(?<score1>.+?)\,(?<score2>.+?),.*$/
hash    = {}
winner  = ''
file = File.open(path)
file.first
file.each do |line|
  matches = line.match(pattern)

  next if matches.nil?

  winner = if matches[:score2] > matches[:score1]
             matches[:team2]
           else
             matches[:team1]
           end

  if hash.key?(winner)
    hash[winner] += 1
  else
    hash.store(winner, 1)
  end
end

file.close

endpros = Time.now
hash.sort_by { |_, v| v }.reverse_each { |item| puts "#{item[0]} - #{item[1]}"}

puts "Starting time  #{starting.strftime('%H:%M:%S.%3N')}"
puts "Processing file #{endpros.strftime('%H:%M:%S.%3N')}"
puts "Processing order file #{Time.now.strftime('%H:%M:%S.%3N')}"
