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
  
end

p ["John", "Peter", "Dave"].my_select { |num| num == "Dave" }

# [1,2,3,20,30,40] array.select { |num| num > 10 }

# [20,30,40]