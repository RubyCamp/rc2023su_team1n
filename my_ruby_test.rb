num = 315

if (0..45).cover?(num) || (315..360).cover?(num) # (0..45 || 315..360)
  puts "here"
end