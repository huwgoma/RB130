def greet(&block)
  puts "block is now a #{block}"
  block.call
end

greet { puts "How was your day?" }
#=> block is now a #<Proc:0x00.. ex.rb:6>
#=> How was your day?

