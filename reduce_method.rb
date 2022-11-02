def reduce(array, opt_accu = 0)
  array.each do |element|
    opt_accu = yield(opt_accu, element)
  end
  opt_accu
end


array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass


=begin
  - passes each element in the
    array to the block
  - after each iteration, it sets
    the accumulator to the 
    return value of the block
  algorithm
=end