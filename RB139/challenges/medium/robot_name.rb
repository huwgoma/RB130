# Robot Name
# Write a program that manages robot factory settings.
# When robots are generated, they have no name. The first time they are booted up,
#   a random name is generated (eg. RX837 or BC811)
# Every once in a while, we need to factory reset a robot, meaning their name 
#   gets wiped. The next time it is booted up, it should respond with a new 
#   random name.
# Names must be random and non-predictable, and should also prevent duplicate
#   names from being used.

# Methods:
# #initialize - not much 
# #name - (generate, assign), and return a name for the robot 
#   - If the generated name is already taken, re-generate name.
#   - names must be 2 capital letters followed by 3 digits.
# #reset - delete the robot's name (reassign to nil)

# Input (#name):
# - No input 

# Output/What it does (#name):
# - Check if @name is already assigned to a value.
#   - If not, generate and assign a value for @name
#     - Implement validation check for @name (prevent dupes)
# - Return @name
# #reset: 
# - Reassign @name to nil (delete name)

# Data:
# - @name: Initially nil in #initialize
#   - To generate: Randomly generate 2 uppercase letters and 3 digits
#   - To prevent duplication: Maybe use a hash? (hash lookup is faster)
#     - When a name is generated, check if it exists as a key in the hash
#       - If it does, regenerate the name and check again until 
#         USED_KEYS[key] returns nil (ie. unused)
#     - Add the value of @name as a key in USED_KEYS (value = true)
# - #reset: Delete the key-value pair in USED_KEYS with the key @name

# Algorithm (#name): When #name is called:
# - Check if @name is nil. If it is, assign @name to a randomly-generated name:
#   Randomly Generating Names:
#   - Create a string - 2 uppercase letters, 3 numbers
#     - VALID NAME CHARACTERS (hash of valid chars, separated by letters/numbers):
#       - Sample 2 letters and 3 numbers and add them to a string.
#       
#   - Validate the name:
#    - Check if string is a key in USED_NAMES
#       - If it is (ie. USED_NAMES[name] => true), generate name value and try again
#       - If it is not (ie. USED_NAMES[name] => nil), name is valid
#   - Add name to USED_NAMES
# - Return @name
require 'pry'

# class Robot
#   VALID_NAME_CHARACTERS = { letters: Array('A'..'Z'), numbers: Array(0..9) }

#   @@used_names = { }

#   def name
#     @name ||= generate_name
#   end

#   def reset
#     @@used_names.delete(@name)
#     @name = nil
#   end

#   private

#   def generate_name
#     loop do
#       name = ''
#       name << VALID_NAME_CHARACTERS[:letters].sample(2).join
#       name << VALID_NAME_CHARACTERS[:numbers].sample(3).join

#       if valid_name?(name)
#         register_name(name)
#         return name
#       end
#     end
#   end

#   def valid_name?(name)
#     # Valid if @@used names does NOT contain the given name as a key.
#     !@@used_names.key?(name)
#   end

#   def register_name(name)
#     @@used_names[name] = true
#   end
# end


# ======================================
# Refactor: Method Responsibility Extraction
class Robot
  NAME_CHARACTERS = { letters: Array('A'..'Z'), numbers: Array(0..9) }

  @@registered_names = { }

  def name
    @name ||= create_unique_random_name
  end

  def reset
    @@registered_names.delete(@name)
    @name = nil
  end

  private

  def create_unique_random_name
    name = ''
    loop do
      name = generate_random_name
      break if unique_name?(name) 
    end

    add_name_to_registered(name)
    name
  end

  def generate_random_name
    letters = NAME_CHARACTERS[:letters].sample(2).join
    numbers = NAME_CHARACTERS[:numbers].sample(3).join

    letters + numbers
  end

  def unique_name?(name)
    # name is unique if it is NOT in @@registered_names as a key.
    !@@registered_names.key?(name)
  end

  def add_name_to_registered(name)
    @@registered_names[name] = true
  end
end

# WHY doesn't this work?
# 2.times { name << VALID_NAME_CHARACTERS[:letters].sample }
# 3.times { name << VALID_NAME_CHARACTERS[:numbers].sample }