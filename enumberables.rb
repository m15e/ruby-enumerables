# Our enumerable methods
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/BlockNesting
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
      arr.my_each { |condition| new_array.push(condition) if yield(condition) }
      new_array
    else
      puts 'This method needs to be called on arrays only'
    end
  end

  def my_all
    arr = self
    if arr.is_a?(Array)
      all_true = true
      arr.my_each { |condition| all_true = yield(condition) ? all_true : false }
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
        all_true = yield(condition) ? false : all_true
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
    arr = self
    new_array = []
    if block_given?
      arr.my_each { |current_element| new_array.push(yield(current_element)) }
    else
      puts 'You should specify block'
    end
    new_array
  end

  def my_inject(num = nil, symb = nil)
    arr = self
    if num.nil? and symb.nil?
      accumulator = self[0]
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
          arr.length.times do |i|
            accumulator = accumulator.send(symb, arr[i])
          end
          accumulator
        end
      end
      if num.nil? or symb.nil?
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
