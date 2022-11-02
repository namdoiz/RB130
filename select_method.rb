=begin

- passes the each element to the block
- if the criteria in the block is passed then the 
  element should be added to another array
- return the selected array

algorithm
  - get the array
  - selected_arr = []
  - iterate over the array
    - counter = 0
    - while counter < array.size
      yield the array[counter] tot the block
    
    - set outcome to the return value when the element has been yielded to the block
    - if outcome is true then put that element into selected_arr
    - return selected_arr
=end

def select(array)
  selected_arr = []
  counter = 0
  while counter < array.size
    outcome = yield(array[counter])
    selected_arr << array[counter] if outcome
    counter += 1
  end
  selected_arr
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
puts ""
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true