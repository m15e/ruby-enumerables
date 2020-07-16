# Our enumerable methods
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/BlockNesting
module Enumerable
  def my_each
    arr = self
    if block_given?
      arr = arr.is_a?(Array) ? arr : arr.to_a
      arr.length.times { |i| yield(arr[i]) }
    end
    arr.to_enum
  end

  def my_each_with_index
    arr = self
    if block_given?
      arr = arr.is_a?(Array) ? arr : arr.to_a
      arr.length.times { |i| yield(arr[i], i) }
    end
    arr.to_enum
  end

  def my_select
    arr = self
    if block_given?
      new_arr = []
      arr = arr.is_a?(Array) ? arr : arr.to_a
      arr.my_each { |condition| new_arr.push(condition) if yield(condition) }
      new_arr
    end
    arr.to_enum
  end

  def my_all(argument = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    is_block = block_given?
    is_argument = !argument.nil?

    if is_block && is_argument
      if argument.is_a?(Regexp)
        all_true = true
        arr.my_each { |current_element| all_true = argument.match(current_element) ? all_true : false }
        all_true
      elsif argument.class == Class
        all_true = true
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? all_true : false }
        all_true
      end
    elsif is_block && !is_argument
      all_true = true
      arr.my_each { |condition| all_true = yield(condition) ? all_true : false }
      all_true
    elsif !is_block && is_argument
      if argument.is_a?(Regexp)
        all_true = true
        arr.my_each { |current_element| all_true = argument.match(current_element) ? all_true : false }
        all_true
      elsif argument.class == Class
        all_true = true
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? all_true : false }
        all_true
      end
    elsif !is_block && !is_argument
      all_true = true
      arr.my_each { |current_element| all_true = current_element ? all_true : false }
      all_true
    else
      arr.to_enum
    end
  end

  def my_any(argument = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    is_block = block_given?
    is_argument = !argument.nil?
    if is_block && is_argument
      if argument.is_a?(Regexp)
        all_true = false
        arr.my_each { |current_element| all_true = argument.match(current_element) ? true : all_true }
        all_true
      elsif argument.class == Class
        all_true = false
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? true : all_true }
        all_true
      end
    elsif is_block && !is_argument
      all_true = false
      arr.my_each { |condition| all_true = yield(condition) || all_true }
      all_true
    elsif !is_block && is_argument
      if argument.is_a?(Regexp)
        all_true = false
        arr.my_each { |current_element| all_true = argument.match(current_element) ? true : all_true }
        all_true
      elsif argument.class == Class
        all_true = false
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? true : all_true }
        all_true
      end
    elsif !is_block && !is_argument
      all_true = false
      arr.my_each { |current_element| all_true = current_element ? true : all_true }
      all_true
    else
      arr.to_enum
    end
  end

  def my_none(argument = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    is_block = block_given?
    is_argument = !argument.nil?

    if is_block && is_argument
      if argument.is_a?(Regexp)
        all_true = true
        arr.my_each { |current_element| all_true = argument.match(current_element) ? false : all_true }
        all_true
      elsif argument.class == Class
        all_true = true
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? false : all_true }
        all_true
      end

    elsif is_block && !is_argument
      all_true = true
      arr.my_each { |condition| all_true = yield(condition) ? false : all_true }
      all_true
    elsif !is_block && is_argument
      if argument.is_a?(Regexp)
        all_true = true
        arr.my_each { |current_element| all_true = argument.match(current_element) ? false : all_true }
        all_true
      elsif argument.class == Class
        all_true = true
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? false : all_true }
        all_true
      end
    elsif !is_block && !is_argument
      all_true = true
      arr.my_each { |current_element| all_true = current_element ? false : all_true }
      all_true
    end
  end

  def my_count(argument = nil)
    counter = 0
    arr = self
    if argument.nil?
      if block_given?        
        arr.my_each { |current_element| counter += 1 if yield(current_element) }
      else
        arr.my_each { counter += 1 }
      end
    else
      arr.my_each { |current_element| counter += 1 if current_element == argument }
    end
    counter
  end

  def my_map
    arr = self
    new_array = []
    if block_given?
      arr.my_each { |current_element| new_array.push(yield(current_element)) }
      new_array
    end
    arr.to_enum
  end

  def my_inject(num = nil, symb = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a

    if num.nil? and symb.nil?
      accumulator = arr[0]
      if block_given?
        (arr.length - 1).times do |i|
          accumulator = yield(accumulator, arr[i + 1])
        end
      end
      accumulator
    else
      if num and symb
        if block_given?
          puts 'we don\'t need a block'
        else
          accumulator = num
          arr.length.times { |i| accumulator = accumulator.send(symb, arr[i]) }
          p "acc: #{accumulator}"
          #accumulator
        end
      end
      if num.nil? or symb.nil?
        p "num #{num} "
        if num.is_a?(Symbol)
          unless block_given?
            accumulator = arr[0]
            symbol = num
            (arr.length - 1).times do |i|
              accumulator = accumulator.send(symbol, arr[i + 1])
            end
            accumulator
          end
        elsif num.is_a?(Integer)
          if block_given?
            accumulator = num
            arr.length.times do |i|
              accumulator = yield(accumulator, arr[i])
            end
            accumulator
          end
        end
      end
    end
  end

  def my_map_with_proc(passed_proc)
    arr = self
    new_array = []
    arr.my_each do |current_element|
      new_array.push(passed_proc.call(current_element))
    end
    new_array
  end

  def my_map_with_proc_block(passed_proc = nil)
    arr = self
    if passed_proc.nil?
      if block_given?
        new_array = []
        arr.my_each do |current_element|
          new_array.push(yield(current_element))
        end
        new_array
      else
        puts 'Provide either proc or block'
      end
    else
      new_array = []
      arr.my_each do |current_element|
        new_array.push(passed_proc.call(current_element))
      end
      new_array
    end
  end
end

def multiply_els(argument = nil)
  return to_enum unless argument

  if argument.is_a? Array
    argument.my_inject(:*)
  else
    puts 'Pass an array'
  end
end

# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/BlockNesting

# arr = [5,10,15]

# rnge = (5..10)

# hsh  = { :bolsym => 3, "strkey" => 2, "bob" => 25  }


#### ALL tests

# p %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any { |word| word.length >= 3 } # -- pass


# p %w[ant bear cat].any? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_any { |word| word.length >= 4 } # -- pass

# p [].any?                                           #=> true -- pass
# p [].my_any    

# p [nil, true, 99].any?
# p [nil, true, 99].my_any

# array = [3, 4, 5, 6, 7]
#range = (3..7)
# hash = { num:2, em:2, peop:5 }

# hash.map { |k,v| p v }

# hash.my_map { |k,v| p v }

p (5..10).reduce(:+)                             #=> 45
# Same using a block and inject
p (5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
p (5..10).reduce(1, :*)                          #=> 151200
# Same using a block
p (5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
puts longest                                        #=> "sheep"

puts '---'*50

p (5..10).my_inject(:+)                             #=> 45
# Same using a block and inject
p (5..10).my_inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
p (5..10).my_inject(1, :*)                          #=> 151200 # -> failing
# Same using a block
p (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.my_inject do |memo, word|
   memo.length > word.length ? memo : word
end
puts longest    


#p range.map #{ |v| v + 5 }
# p range.inject { |v| v + 1 }
# p range.my_inject { |v| v + 1 }

# array = [1,2,4,2]

# puts "original"

# p array.count
# p array.count(2)
# p array.count { |x| x%2 == 0 }

# puts '---'*50

# puts "my_arr"

# p array.my_count
# p array.my_count(2)
# p array.my_count { |x| x%2 == 0 }

# p hash.all?{|i| i>1}

#p array.count(3) { |n| n >= 5 } # works but block not used
#p array.count { |n| n >= 5 } # if block given inside of block is counted

#p array.count(2) # counts number of occurences
# p range.count #{|k,v| v > 3 }  # only block or argument - argument takes priority
# p range.my_count #{|k,v| v > 3 }


#p array.count 

# p %w[ant bear cat].any?(/t/)
# p %w[ant bear cat].my_any(/t/){|jjjh|}                     #=> false -- fail

# p [1, 2i, 3.14].all?( Numeric )                       #=> true -- fail
# p [1, 2i, 3.14].my_all(Numeric){|kkjh|}

# p [nil, true, 99].all?                              #=> false -- fail
# p [nil, true, 99].my_all

# p (1..5).all?(String)
# p (1..5).my_all(String)





#p arr.select { |n| !n.zero? }
#p rnge.select { |n| !n.zero? }

# p hsh.select { |n,v| p "#{n},v: #{v}" }

# puts "---"*50

# p hsh.my_select { |n,v| p "#{n},v: #{v}" }

# p [1,2,3,4,5].select #{ |num|  num.even?  } 

# p [1,2,3,4,5].my_select #{ |num|  num.even?  } 


#p hsh.to_a #{|v| puts "v: #{v}" }
#hsh.my_each {|v| puts "v: #{v}" }
# rnge.each {|v| puts "v: #{v}" }

# arr.each {|v| puts "v: #{v}" }

# rnge.my_each_with_index { |val,index| puts "index: #{index} for #{val}" if val < 30}
# puts " "
# rnge.each.with_index { |val,index| puts "index: #{index} for #{val}" if val < 30}

# %w(cat dog wombat).my_each_with_index { |i, idx| p "item: #{i} idx:  #{idx}" }

# %w(cat dog wombat).each.with_index { |i, idx| p "item: #{i} idx:  #{idx}" }   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
#p (5..10).to_a

# hash = Hash.new
# %w(cat dog wombat).my_each_with_index { |item, index|
#   hash[item] = index
# }

# p hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}


# p %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none { |word| word.length == 5 } #=> true==>pass
# p %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none { |word| word.length >= 4 } #=> false ==>pass
# p %w{ant bear cat}.none?(/d/)                        #=> true
# p %w{ant bear cat}.my_none(/d/)                        #=> true==>pass
# p [1, 3.14, 42].none?(String)                         #=> false
# p [1, 3.14, 42].my_none(String)                         #=> false==>fail
# p [].none?                                           #=> true
# p [].my_none                                           #=> true
# p [nil].none?                                        #=> true
# p [nil].my_none                                        #=> true==>passing
# p [nil, false].none?                                 #=> true
# p [nil, false].my_none                                 #=> true==>passing
# p [nil, false, true].none?                             #=> false
# p [nil, false, true].my_none                           #=> false==>pass

