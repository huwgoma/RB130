names = ['hugo', 'KEVIN']


# Array#map
def map
  self.each_with_object([]) do |element, array|
    array << yield(element)
  end
end

proc = :capitalize.to_proc 
#=> #<Proc:0x00..(&:capitalize) (lambda)>
names.map(&proc)

# When this Proc is executed, the method
# named by the calling Symbol will be invoked
# on the first given argument.
proc.call('hugo')  #=> 'Hugo'
proc.call('KEVIN') #=> 'Kevin'

# When this Proc is executed, the method named by the calling Symbol 
# will be invoked on the first given argument.

names.map { |obj| obj.capitalize }

# The & operator converts the
# returned Proc into a block.

# The Proc is then converted to a block by the & operator.
names.map(&proc)


# Array#map iterates through the calling collection and passes 
# each element to the given block. The block, in turn, invokes the
# symbol-named method (#capitalize) on each yielded element.

  #=> ['Hugo', 'Kevin']


# Array#map yields each element to the given block; the block, in turn,
# invokes the method named by the symbol (#capitalize) on the yielded argument. 
