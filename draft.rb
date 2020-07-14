def draft
    ['people','foo', 'class'].each_with_index do |curr, i|
        puts "current number is #{curr} and it's on index #{i}"
    end
end

draft()

# def my_each
#     self.length.times do |i|
#         yield(self[i])
#     end
# end

# [1,2,3,4].my_each {|curr| puts "#{curr}"}
