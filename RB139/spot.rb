def return_proc(&block)
  Proc.new(&block)
end

return_proc { puts 'Hello' }.call

# Create a Proc - factory for creating mini-methods

# def return_proc(message)
#   Proc.new {|str| "#{message} #{str}" }
# end

# p return_proc("Hello").call("World")





# Use Case for returning Procs?
# Deferring Implementation - in 2 stages
# - Defer the first part of the message to the method invocation
# - Defer the second part of the message to the Proc invocation



# Challenges - When did you feel ready?
# List of practice questions for each concept  
# - eg. write a method that illustrates returning a closure
