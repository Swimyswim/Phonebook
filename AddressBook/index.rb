
require './MenuItems'

Menu()

=begin
puts "ADDRESS BOOK"
puts "1. Add Contact"
puts "2. Edit Contact"
puts "3. View Contact"
puts "4. Delete Contact"

puts "Please Select from the above options"

response1 = gets.chomp

if response1 == "1"
  AddContact()
  #index = index.to_i + 1

elsif response1 == "2"
  EditContact()

elsif response1 == "3"
  ViewContact()

elsif response1 == "4"
  DeleteContact()

else
  puts "Invalid response"
  Menu()



end
=end
