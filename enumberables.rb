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

  def my_inject(num=nil, symb=nil)
    if num.nil? and symb.nil?
      accumulator = self[0]
      #there is no number and no symbol
      if block_given?
        (self.length-1).times do |i|    
          accumulator = yield(accumulator, self[i+1])               
        end 
      end
      accumulator
    else
      #there is probably both number and symbol
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
      #there is probably either number or symbol
      if num.nil? or symb.nil?
        
        param = num.class or symb.class
        
        if param==Symbol
          if block_given?
            puts 'You don\'t need a block here'
          else
            accumulator=self[0]
            (self.length-1).times do |i|
              # accumulator=accumulator.send(symb,self[i+1])
              puts self[i]
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

      #   # there symbol no num
      #   if symb.is_a?(Symbol)
      #     if block_given?
      #       puts 'You don\'t need a block here'
      #     else
      #       accumulator=self[0]
      #       (self.length-1).times do |i|
      #         accumulator=accumulator.send(symb,self[i+1])
      #       end
      #       accumulator
      #     end
      #   end
      # elsif !num.nil? and symb.nil?

      #   #there is only num no symb
      #   if block_given?
      #     accumulator=num
      #     self.length.times do |i|
      #       accumulator=yield(accumulator,self[i])
      #     end
      #     accumulator
      #   else
      #     puts 'You need to pass a block'
      #   end
        
      end
    end
  end









  #   if symb.nil?
  #     # check for string
  #     if self[0].is_a?(String)
  #       accumulator = self[0]
  #     else
  #       accumulator = 0
  #     end
  #   elsif symb.is_a?(Symbol)

  #     accumulator = self[0]
      
  #     (self.length-1).times do |counter|
  #       accumulator = accumulator.send(symb, self[counter+1])
  #     end
  #   end  
  #   if block_given?
  #     self.my_each do |current_element|    
  #       accumulator = yield(accumulator, current_element)               
  #     end    
  #   end
  #   accumulator
  # end

end
# TODO: or self.kind_of?(Hash) methods should apply to dictionaries also

# count
# p '\n'

######################################
arry = [1,2,3,4]
# puts arry.inject(:+)
puts arry.my_inject(:+)
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

