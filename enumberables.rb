module Enumerable
  def my_each
    if self.kind_of?(Array)
      self.length.times do |i|
        yield(self[i])
      end
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_each_with_index
    if self.kind_of?(Array)
      self.length.times do |i|
        yield(self[i], i)
      end
    else
      puts 'This method needs to be called on arrays only'
    end
  end
  
  def my_select 
    if self.kind_of?(Array)
      new_array = []
      self.my_each do |condition|
        if yield(condition) == true
          new_array.push(condition)
        end
      end
      return new_array
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_all
    if self.kind_of?(Array)
      all_true = true
      self.my_each do |condition|
        if yield(condition) != true
          all_true = false
        end
      end
      return all_true
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_any
    if self.kind_of?(Array)
      all_true = false
      self.my_each do |condition|
        if yield(condition) == true
          all_true = true
        end
      end
      return all_true
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_none
    if self.kind_of?(Array) 
      all_true = true
      self.my_each do |condition|
        if yield(condition) == true
          all_true = false
        end
      end
      return all_true
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_count(argument=nil)
   counter=0
   if argument.nil?
    if block_given?
      self.my_each do |current_element|
        if yield(current_element) 
          counter+=1
        end
      end
    else
      self.my_each {counter+=1}
    end
   else
    self.my_each do |current_element|
      if current_element == argument
        counter+=1
      end
    end
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

end
# TODO: or self.kind_of?(Hash) methods should apply to dictionaries also

# count

# ary1=['people','people','foo', 'class','microverse','git']
# ary = [1, 2, 4, 2]
# puts ary1.my_count             #=> 4
# p ary.count(2)            #=> 2
# puts ary.count{ |x| x%2==0 } #=> 3


# none

# %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
# %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
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

################################
# a = [18, 22, 33, 3, 5, 6] 
# puts a.my_map {|num| num > 10 }
# out: [true, true, true, false, false, false]
# b = [1, 4, 1, 1, 88, 9] 
# puts b.my_map {|x| x.odd? }
# out: [true, false, true, true, false, true]
# c = [18, 22, 3, 3, 53, 6] 
# puts c.my_map {|num| num > 10 }
# out: [true, true, false, false, true, false]
# puts c.my_map {|num| num.even? }
# out: [true, true, false, false, false, true]
# array = [1, 2, 3]
# puts 'people'.my_map { |string| string+2}
# # out: ["A", "B", "C"]
