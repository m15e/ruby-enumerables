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
  
  
end

p [ ].my_all { |num| num > 10 }

p [ ].all? { |num| num > 10 }

# [1,2,3,20,30,40] array.select { |num| num > 10 }

# [20,30,40]