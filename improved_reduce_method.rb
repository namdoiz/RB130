def reduce(array, opt_accu = 0)
  if Integer === array[0]
    array.each do |element|
      opt_accu = yield(opt_accu, element)
    end
    opt_accu
  else
    opt_accu = array[0].class.new
    array.each do |element|
      opt_accu = yield(opt_accu, element)
    end
    opt_accu
  end
end


array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']

=begin
  - passes each element in the
    array to the block
  - after each iteration, it sets
    the accumulator to the 
    return value of the block
  - if youre given an array of arrays
    - return array
  - if youre given an array of strings
    - return string
  - if youre given an array of numbers
    - return number

  algorrithm
    - check what the first 
      element is
    - if it is a number then 
      set opt_accu to 0
    - if it is an array
      set opt_accu to []
    - if it is a string
      set opt_accu to ""
=end