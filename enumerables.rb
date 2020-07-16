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
        unless block_given?
          accumulator = num
          arr.length.times { |i| accumulator = accumulator.send(symb, arr[i]) }                    
          accumulator                           
        end      
      elsif num.nil? or symb.nil?        
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
    arr = arr.is_a?(Array) ? arr : arr.to_a
    new_array = []
    arr.my_each do |current_element|
      new_array.push(passed_proc.call(current_element))
    end
    new_array
  end

  def my_map_with_proc_block(passed_proc = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    if passed_proc.nil?
      if block_given?
        new_array = []
        arr.my_each do |current_element|
          new_array.push(yield(current_element))
        end
        new_array
      else
        arr.to_enum
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
