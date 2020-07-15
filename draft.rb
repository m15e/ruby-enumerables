# def draft
#   ['r','u','b','y'].length.times do |i|
#     puts i
#   end
# end

# draft()

# # def my_each
# #     self.length.times do |i|
# #         yield(self[i])
# #     end
# # end

# # [1,2,3,4].my_each {|curr| puts "#{curr}"}
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


