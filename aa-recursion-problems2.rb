require 'byebug'

# Write a recursive method, range, that takes a start and an end 
# and returns an array of all numbers in that range, exclusive. 
# For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, 
# you can return an empty array.

def range(num1, num2)
    if num1 == num2
        [num1]
    elsif num1 + 1 == num2
        [num1]
    else
        range(num1, num2 - 1) << num2 - 1
    end
end

# p range(1, 2)
# p range(-4, 4)
# p range(-8, -1)
# p range(0, 1)
# p range(-5, 0)

# Write both a recursive and iterative version of sum of an array.

# When we dup an Array, it creates a new array to hold the elements, 
# but doesn't recursively dup any arrays contained therein. So the 
# dup method creates one new array, but just copies over references to 
# the original interior arrays.

# # Sometimes you want a shallow dup and sometimes you want a deep dup. 
# Ruby keeps things simple by giving you shallow dup, and letting you write deep dup yourself.

# # Using recursion and the is_a? method, write an Array#deep_dup method 
# that will perform a "deep" duplication of the interior arrays.

class Array

    def recursive_sum
        sum = 0
        (0...self.length).each { |idx| sum += self[idx] }
        sum
    end

    def recursive_sum
        if self.length == 0
            0
        else
            self[0...-1].recursive_sum + self[-1]
        end
    end

    def deep_dup
        if self.length <= 1
            if self[0].is_a? Array
                [self[0].dup]
            else
                result = []
                result << self[0]
            end
        else
            self[0...-1].deep_dup << self[-1].dup
        end
    end

end

# p [1, 2].recursive_sum
# p [4, 5, 1].recursive_sum
# p [].recursive_sum
# p [4].recursive_sum

# p [1, [2]].deep_dup
# p [1, 2, 3].deep_dup
# p [[1], 2, 3].deep_dup
# p [[1, 2], [3, 4]].deep_dup
# p [[1, [2]], 3, [4]].deep_dup

# arr1 = [[1], 2, 3]
# arr2 = arr1.deep_dup
# arr2[0] << 2
# p arr1
# p arr2


# Write two versions of exponent that use two different recursions:

# # this is math, not Ruby methods.

# # recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

# # recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exp1(base, exponent)
    if exponent == 0
        1
    else
        exp(base, exponent - 1) * base
    end
end

def exp2(base, exponent)
    if exponent == 0
        1
    elsif exponent == 1
        base
    elsif exponent % 2 == 0
        exp2(base, exponent / 2) ** 2
    else
        base * (exp2(base, (exponent - 1) / 2) ** 2)
    end
end

# p exp2(2, 0)
# p exp2(2, 1)
# p exp2(2, 2)
# p exp2(2, 8)

# Write a recursive Fibonacci method. 
# The method should take in an integer n and return the 
# first n Fibonacci numbers in an array.

def iterative_fibonacci(n)
    result = []
    (1..n).each do |num|
        if num == 1
            result << 0
        elsif num == 2
            result << 1
        else 
            result << (result[-1] + result[-2])
        end
    end
    result
end

def recursive_fibonacci(n)
    if n == 1
        [0]
    elsif n == 2
        recursive_fibonacci(1) << 1
    else
        recursive_fibonacci(n-1) << (recursive_fibonacci(n-1)[-1] + recursive_fibonacci(n-1)[-2])
    end
end

# p recursive_fibonacci(1) 
# p recursive_fibonacci(2)
# p recursive_fibonacci(3)
# p recursive_fibonacci(4)
# p recursive_fibonacci(5)
# p recursive_fibonacci(6)

# p iterative_fibonacci(1) 
# p iterative_fibonacci(2)
# p iterative_fibonacci(3)
# p iterative_fibonacci(4)
# p iterative_fibonacci(5)
# p iterative_fibonacci(6)

# Write a recursive binary search: bsearch(array, target). 
# Note that binary search only works on sorted arrays. 
# Make sure to return the location of the found object (or nil if not found!).

def bsearch(array, target, start=0)
    midpoint = array.length / 2
    return nil if array == []
    if array[midpoint] == target
        return midpoint + start
    elsif array[midpoint] > target
        bsearch(array[0...midpoint], target, start)
    else
        bsearch(array[(midpoint + 1)..-1], target, midpoint + 1)
    end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

# Implement a method merge_sort that sorts an Array

def merge_sort(array)

    midpoint = array.length / 2
    if array.length == 1
        return array
    else
        merge(merge_sort(array[0...midpoint]), merge_sort(array[midpoint..-1]))
    end

end

def merge(left, right)

    result = []
    until left.length == 0 || right.length == 0 do
        result << (left.first <= right.first ? left.shift : right.shift)
    end
    result + left + right

end

# p merge_sort([38, 27, 43, 3, 9, 82, 10])
# p merge_sort([9, 1, 5, 4])

# Write a method subsets that will return all subsets of an array.

def subsets(arr)
    
    return [[]] if arr == []

    last = arr.pop
    first = subsets(arr)
    second = Array.new(first.length)
    (0...second.length).each do |idx|
        if first[idx] == []
            second[idx] = [last]
        else
            second[idx] = *first[idx], last
        end
    end
    return first.concat(second)

end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

# Write a recursive method permutations(array) that calculates all 
# the permutations of the given array. For an array of length n 
# there are n! different permutations. So for an array with three 
# elements we will have 3 * 2 * 1 = 6 different permutations.

def permutations(arr)
    return [arr] if arr.length <= 1
    last = arr.pop
    perms = permutations(arr)
    result = []
    perms.each do |perm|
        (0..perm.length).each do |i|
            result << perm[0...i] + [last] + perm[i..-1]
        end
    end
    result
end

# p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
                        #     [2, 1, 3], [2, 3, 1],
                        #     [3, 1, 2], [3, 2, 1]]

def make_change(amount, coins=[25, 10, 5, 1])
    # debugger
    return [amount] if coins.include?(amount)

    result = []

    selection = coins.select { |coin| coin < amount }
    selection.sort.reverse!
    result << selection[0]
    result.concat(make_change(amount - selection[0], coins))

end

p make_change(39)
p make_change(6)
p make_change(2)
p make_change(51)
p make_change(20)
p make_change(15, [10, 7, 1])