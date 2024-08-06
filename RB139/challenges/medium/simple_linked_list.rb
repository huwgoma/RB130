require 'pry'
# Simple Linked List
# - A single-linked list consists of one or more Elemenets. 
# - Each Element contains some data and a Next attribute, pointing to the 
#   next element in the sequence.
# - Elements are in LIFO order; they are added and removed to/from the top
#   of the stack (ie. the last added element is the first to be removed)

# [1 <- 2 <- 3] <- 4 | [1 <- 2 <- 3 <- 4]
# tail      head       tail           head

# Rules:
# - Do not use an Array.
# Element: @datum and @next (default nil).
# - #tail? returns true if self is at the bottom of the list (ie. next is nil)
# LinkedList:
#   @head: Points to the top Element of the list 
#   #size: Returns the 'size' of the List; start at @head (size = 0) and increment
#     size until Element#tail? returns true.
#   #empty?: Check if #size is 0.
#   
#   #push: Push an Element to the Top of the List.
#     - Create an Element with the given @datum; set @next to the current @head;
#       set @head to the newly-created and added Element.
#   #peek: Return the @datum of the @head element.
#   
#   #pop: Remove an Element from the Top of the List, and return its @datum
#     - Isolate the current @head Element; Reassign @head to the current @head's
#       @next Element.
#     - Set old head Element's @next to nil.

#   ::from_a: Takes an Array (or nil; convert with to_a) as input and outputs a 
#     new LinkedList object consisting of the elements from the given Array.
#   - Elements are pushed in reverse order. 
#     [1, 2, ..., 9, 10] => [10 <- 9 <-... <- 2 <- 1] head

#     - Instantiate a new Linked List (@head = nil)
#     - Reverse the array, then iterate through array. For each object:
#       - Create an element with @datum = object and @next = @head.
#       - Assign @head to the newly-created + Pushed Element.
#       (#push)

#   #to_a: Returns an Array representing the linked Elements.
#     LL: [3 <- 2 <- 1]  => A: [1, 2, 3]
#   - Elements are added to the array from @head to tail.
#   - Start from element = @head; add the current Element's @datum to the array;
#     Reassign element to element.next and repeat until element.next is nil

#   #reverse: Reverse a Linked List and return it as a new linked list 
#   [3 <- 2 <- 1] => [1 <- 2 <- 3]
#   - Instantiate a new Linked List
#   - Start at the element = @head of self Linked List 
#     - Create an Element with @datum = element.datum, @next = new_list.head
#     - Set new list @head to newly-pushed Element
#   - Reassign element to element.next
#   - Stop when element.next is nil.

class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum, next_ele = nil)
    @datum, @next = datum, next_ele
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  def self.from_a(array)
    new_list = self.new
    array.to_a.reverse_each { |obj| new_list.push(obj) }
    new_list
  end

  attr_accessor :head

  def initialize
    @head = nil
  end

  def push(obj)
    element = Element.new(obj, head)
    self.head = element
  end

  def pop
    element = head
    self.head = element.next
    element.next = nil
    element.datum
  end

  def peek
    head.datum if head
  end

  def size
    count = 0
    each { count += 1 }
    count
  end

  def empty?
    size.zero?
  end

  def reverse
    new_list = self.class.new
    each { |ele| new_list.push(ele.datum) }
    new_list
  end

  def to_a
    array = []
    each { |ele| array << ele.datum }
    array
  end

  private

  def each
    element = head
    until element.nil?
      yield(element) if block_given?
      element = element.next  
    end
    self
  end
end