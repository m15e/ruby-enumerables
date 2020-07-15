# Our enumerable methods
# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    arr = self
    if arr.is_a?(Array)
      arr.length.times do |i|
        yield(arr[i])
      end
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_each_with_index
    arr = self
    if arr.is_a?(Array)
      arr.length.times do |i|
        yield(arr[i], i)
      end
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_select
    arr = self
    if arr.is_a?(Array)
      new_array = []
      arr.my_each do |condition|
        if yield(condition) == true
          new_array.push(condition)
        end
      end
      new_array
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_all
    arr = self
    if arr.is_a?(Array)
      all_true = true
      arr.my_each do |condition|
        if yield(condition) != true
          all_true = false
        end
      end
      all_true
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_any
    arr = self
    if arr.is_a?(Array)
      all_true = false
      arr.my_each do |condition|
        all_true = yield(condition) || all_true
      end
      all_true
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_none
    arr = self
    if arr.is_a?(Array)
      all_true = true
      arr.my_each do |condition|
        if yield(condition)
          all_true = false
        end
      end
      all_true
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_count(argument = nil)
    counter = 0
    arr = self
    if argument.nil?
      if block_given?
        arr.my_each { |current_element| yield(current_element) ? counter += 1 : '' }
      else
        arr.my_each { counter += 1 }
      end
    else
      arr.my_each { |current_element| current_element == argument ? counter += 1 : '' }
    end
    counter
  end

  def my_map
    new_array = []
    if block_given?
      self.my_each do |current_element|
        new_array.push(yield(current_element))
      end
    else
      puts 'You should specify block'
    end
    new_array
  end

  def my_inject(num=nil, symb=nil)
    if num.nil? and symb.nil?
      accumulator = self[0]
      if block_given?
        (self.length-1).times do |i|    
          accumulator = yield(accumulator, self[i+1])               
        end 
      end
      accumulator
    else
      if num and symb
        if block_given?
          puts 'we don\'t need a block'
        else
          accumulator=num
          self.length.times do |i|
            accumulator=accumulator.send(symb, self[i])
          end
          accumulator
        end
      end
      if num.nil? or symb.nil?
        if num.is_a?(Symbol)
          if block_given?
            puts 'You don\'t need a block here'
          else
            accumulator=self[0]
            symbol = num;
            (self.length-1).times do |i|
              accumulator=accumulator.send(symbol,self[i+1])
            end
            accumulator
          end
        elsif param==Integer
          if block_given?
            accumulator=num
            self.length.times do |i|
              accumulator=yield(accumulator,self[i])
            end
            accumulator
          end
        end
      end
    end
  end

  def my_map_with_proc(passed_proc)
    new_array = []
    self.my_each do |current_element|
      new_array.push(passed_proc.call(current_element))
    end
    new_array
  end

  def my_map_with_proc_block(passed_proc=nil)
    if passed_proc.nil?
      if block_given?
        new_array = []
        self.my_each do |current_element|
          new_array.push(yield(current_element))
        end
        new_array
      else
        puts 'Provide either proc or block'
      end
    else 
      new_array = []
      self.my_each do |current_element|
        new_array.push(passed_proc.call(current_element))
      end
      new_array
    end
  end
end

def multiply_els(argument)
  if argument.nil?
    #there is no argument
  else
    #there is argument
    if argument.is_a? Array
      argument.my_inject(:*)
    else
      puts 'Pass an array'
    end
  end
end
# rubocop:enable Metrics/ModuleLength

# ##################################################
# numbers = [21, 42, 303, 499, 550, 811]

# # puts numbers.my_any { |number| number > 500 }
# #=> true

# puts numbers.my_any { |number| number < 20 }
# #=> false

##################################################
# array = ['people','from','this','this','company']
# array.my_each {|curr| puts curr}

# TODO: or self.kind_of?(Hash) methods should apply to dictionaries also

# count
# p '\n'

######################################
# arry = [1,2,3,4,5]
# puts arry.inject(:*)
# puts arry.my_inject(:*)
# puts multiply_els([1,2,3])
# longest = %w{ sheep cat bear }.my_inject do |memo, word|
#   #p memo
#   #p word
#   memo.length > word.length ? memo : word
# end
# p longest   

# ar = [2,2,2,2]

# p ar.my_inject {|a, v| a + v}


# symbol +, %, -, /, //


# ta = ['ss','dsad','sdasd','asdas']
# p ta.inject(:*)

# p ta.my_inject { |sum, n| sum + n }
# p ta.inject { |sum, n| sum + n }




# ary1=['people','people','foo', 'class','microverse','git']
# ary = [1, 2, 4, 2]
# puts ary1.my_count             #=> 4
# p ary.count(2)            #=> 2
# puts ary.count{ |x| x%2==0 } #=> 3


# none

# puts %w{ant bear cat}.my_none { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none { |word| word.length >= 4 } #=> false
# %w{ant bear cat}.none?(/d/)                        #=> true
# [1, 3.14, 42].none?(Float)                         #=> false
# [].none?                                           #=> true
# [nil].none?                                        #=> true
# [nil, false].none?                                 #=> true
# [nil, false, true].none?                           #=> false

# p [1, 3.14, 42].none?(Float) # => returns true

# p [nil, false, true].my_none {}

#p [].my_none { |num| num.kind_of?(Float) } # => false

#p ['ant', 'bear', 'cat'].none? { |word| word.length >= 4 }

# [1,2,3,20,30,40] array.select { |num| num > 10 }

# [20,30,40]

######################################################################
# a = [18, 22, 33, 3, 5, 6] 
# proc_to_pass = Proc.new {|num| num > 10 }
# puts a.my_map_with_proc_block(proc_to_pass) {|num| num > 10 }
# out: [true, true, true, false, false, false]
# b = [1, 4, 1, 1, 88, 9] 
# proc_to_pass = Proc.new {|x| x.odd? }
# puts b.my_map_with_proc(proc_to_pass)
# out: [true, false, true, true, false, true]
# c = [18, 22, 3, 3, 53, 6] 
# proc_to_pass = Proc.new {|num| num > 10 }
# puts c.my_map_with_proc(proc_to_pass)
# out: [true, true, false, false, true, false]
# proc_to_pass = Proc.new {|num| num.even? }
# puts c.my_map_with_proc(proc_to_pass)
# out: [true, true, false, false, false, true]
# array = ['a', 'b', 'c']
# proc_to_pass = Proc.new { |string| string.upcase}
# puts array.my_map_with_proc(proc_to_pass)
# puts 'people'.my_map { |string| string+2}
# # out: ["A", "B", "C"]

