# Lenient Arity - Blocks & Procs
def example_method; yield; end

example_method { |param| p param }
#=> nil

proc = Proc.new { puts 'Hello' }

proc.call('Unused argument')
#=> Hello







# Strict Arity - Methods & lambdas
# def example_method(param)
#   puts param
# end

# example_method('Hello')
# #=> Hello
# example_method()
# #=> ArgumentError: given 0, expected 1

# lmb = -> { puts 'Hello' }

# lmb.call
# #=> Hello
# lmb.call('Hello') 
# #=> ArgumentError: given 1, expected 0

