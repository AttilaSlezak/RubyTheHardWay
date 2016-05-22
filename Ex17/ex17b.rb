from_file, to_file = ARGV
script = $0

puts "Copying from #{from_file} to #{to_file}"

File.open(to_file, 'w') do |fw|
  File.open(from_file) do |f| 
    puts "The output file is #{f.read().length} bytes long"
    puts "Does the output file exist? #{File.exists? to_file}"
    puts "Ready, hit RETURN to continue, CTRL-C to abort."
    STDIN.gets
    f.seek(0)
    fw.write(f.read())
  end
end

puts "Alright, all done."