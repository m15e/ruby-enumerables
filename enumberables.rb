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

  def my_count
    
  end
  
  
end

# TODO: or self.kind_of?(Hash) methods should apply to dictionaries also

# count

# ary = [1, 2, 4, 2]
# ary.count               #=> 4
# ary.count(2)            #=> 2
# ary.count{ |x| x%2==0 } #=> 3


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

p [nil, false, true].my_none {}

#p [].my_none { |num| num.kind_of?(Float) } # => false

#p ['ant', 'bear', 'cat'].none? { |word| word.length >= 4 }

# [1,2,3,20,30,40] array.select { |num| num > 10 }

# [20,30,40]