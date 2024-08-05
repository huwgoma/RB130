# Simple Linked List
# The linked list is a fundamental data structure in computer science. The simplest
# linked list is a single-linked list:
# - Each element in the list contains some data and a NEXT field, pointing to the 
#   next element in the list.

# Create a single-linked list whose elements may contain a range of data (eg. 1-10)
# - Provide methods to reverse the list, and convert the list to/from an Array.

# Two Classes: Element and SimpleLinkedList
# Element:
# - Takes 1-2 arguments (datum and next); has accessors for both
# - #tail? method returns true if the element has no next element (?)
# SimpleLinkedList
# - No arguments on construction
# - #size returns number of elements
# - #empty? returns true if size == 0
# - #push creates and adds an Element to the FRONT of the list
#   - Link the current element's next to previous element
# - #peek returns the datum of the FIRST element (?)
# - #head returns the FIRST Element (?)
# - #pop removes and returns the FIRST element from the list

# - ::from_a:
#   - Accepts an array and instantiates a new SimpleLinkedList with @list = array
#   - If nil, @list = empty array

# - #to_a: Returns an array representing the elements in the list
# - #reverse: Return a NEW LinkedList object with list elements reversed
#   - Reverse the next associations too


# Data/Algorithm:
# Element: @datum and @next
# - @next defaults to nil unless given
# List:
# #initialize may accept an optional argument
# - If argument is an array, @list = array. Otherwise @list = []
# #push:
# - Create an element from the given data; @datum = datum, @next = the current
#   first element in the list (ie. @list.first / head)
# #pop:
# - Remove the first element from the list; set its @next to nil

# ::from_a: Given Array or nil (to_a => [])
# list = [], array [1, 2]
# Output => [Ele(d = 1, n = Ele(2)), Ele(d = 2, n = nil)]
# Iterate through each element in array in reverse order; for each element:
# - Create element from current object; next = first item in list 
# - Add element to front of list
# - Instantiate new LinkedList with @list = list

# to_a: 
# - Return @list (i think?) -- return @list's datum values

# #reverse:
# - Reverse @array and map duplicate each element
#   [Ele(D: 1, N: Ele 2), Ele(D: 2, N: nil)] 
#   => [Ele(D: 2, N: nil), Ele(D: 1, N: Ele 2)]

# Iterate through reversed duped array, 2 elements at a time (overlap). For each pair:
# [ele3, ele2], [ele2, ele1]
# - Set the first Element's @next to the second element
# EOI:
# - Set the last Elements @next to nil.



# [1 -> 2 -> 3]
# [3 -> 2 -> 1]

require 'pry'

class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum, next_ele = nil)
    @datum, @next = datum, next_ele
  end

  def tail?
    !self.next
  end
end

class SimpleLinkedList
  def self.from_a(array)
    list = []

    array.to_a.reverse_each do |obj|
      element = Element.new(obj, list.first)
      list.unshift(element)
    end

    self.new(list)
  end

  attr_reader :array

  def initialize(array = [])
    @array = array
  end

  def size
    array.size
  end

  def empty?
    array.empty?
  end

  def push(obj)
    element = Element.new(obj, head)
    array.unshift(element)
  end

  def head
    array.first
  end

  def peek
    head&.datum
  end

  def pop
    removed_item = array.shift
    removed_item.next = nil
    removed_item.datum
  end

  def reverse
    reversed_copy = array.reverse_each.map(&:dup) 
    reversed_copy.each_cons(2) do |ele1, ele2|
      ele1.next = ele2
    end
    reversed_copy.last.next = nil

    self.class.new(reversed_copy)
  end

  def to_a
    array.map(&:datum)
  end
end


# ==========================
# Launch School Solution
# - Single-linked list: Each element only knows about the NEXT element in the list, 
#   referenced by the #next field.
# - 

# - Element: 
#   - Expects at least one argument (data)
#   - Second optional argument is another Element (next element)
#   - Newer elements will be placed BEFORE the preceding elements (LIFO)
#   - #tail? Returns true if the current element is the TAIL of the list (ie. does
#     not have a next element)
# 
