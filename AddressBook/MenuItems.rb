require 'json'

def AddContact
  begin

puts "Please Enter a first name of the contact"

firstname = gets.chomp()
if firstname == "" and !/\w/.match(firstname)
    puts "selection is invalid, please try again"
    AddContact()
  else

puts "Enter the surname of the contact"

surname = gets.chomp()
if surname == "" and !/\w/.match(surname)
    puts "selection is invalid, please try again"
    AddContact()
  else

puts ("Enter the Phone number of " + firstname + " " + surname)
phoneNumber = gets.chomp()
if phoneNumber == "" and !/\w/.match(phoneNumber)
    puts "selection is invalid, please try again"
    AddContact()
  else

puts "SUMMARY"
puts (" Name " + firstname + " " + surname)
puts ("Contact No: " + phoneNumber)
puts "Proceed to save contact?"
puts "1. Yes"
puts "2. No"
summary = firstname + " " + surname + " " + phoneNumber + "\n"

response1a = gets.chomp()

  if response1a == "1"

    data = Hash.new
      data["firstname"] = firstname
      data["surname"] = surname
  data["phoneNumber"] = phoneNumber
    json_data = data.to_json
      File.open("data.json", "a+") do |f|
          f.write(json_data + "\n")
      end


    puts "Contact Saved"
    Menu()

      elsif response1a == "2"
        puts "Exit?"
        puts "1. Yes"
        puts "2. No"

        response1b = gets.chomp()
          if response1b == "1"
            return

          else
          Menu()
          end
        end
      end
    end
  end

      rescue Exception => e
        puts "Error"

        end


end

def EditContact
  begin
  puts "Current saved contacts"


count = 1
file = File.new("data.json", "r")
while (line = file.gets)
the_values = JSON.parse(line)
puts ''
puts "#{count}. Name: #{the_values["firstname"]}, #{the_values["surname"]}"
puts "phoneNumber #{the_values["phoneNumber"]}"
  count = count + 1
end
file.close

puts "Please select contact you want to edit"
  arr = IO.readlines("data.json")
  STDOUT.flush
  _del = gets.chomp
  if !/\A\d+\z/.match(_del)
      puts "selection is invalid, please try again"
      EditContact()
  else
  del = _del.to_i - 1

  json_contact = arr[del]
  hash_contact = JSON.parse(json_contact)

  puts "This is the current contact:: firstname: #{hash_contact["firstname"]}, surname: #{hash_contact["surname"]}"
  puts "Enter the First Name:"
  STDOUT.flush
  firstname = gets.chomp
  if firstname != "" and !/\w/.match(firstname)
      puts "selection is invalid, please try again"
      EditContact()
    else

  puts "Enter the Surname:"
  STDOUT.flush
  surname = gets.chomp
  if surname != "" and !/\w/.match(surname)
      puts "selection is invalid, please try again"
      EditContact()
    else

  puts "Enter the Phone Number"
  STDOUT.flush
  phoneNumber = gets.chomp
  if phoneNumber != "" and !/\A\d+\z/.match(phoneNumber)
      puts "selection is invalid, please try again"
      EditContact()
    else

  firstname1 = edit_fname(firstname, hash_contact)
  surname1 = edit_lname(surname, hash_contact)
  phoneNumber1 = edit_pnum(phoneNumber, hash_contact)

  puts "Final result :: firstname: #{firstname1}, surname: #{surname1}, phoneNumber: #{phoneNumber1}"

  edit = '{"firstname":"'+firstname1+'","surname":"'+surname1+'","phoneNumber":"'+phoneNumber1+'"}'

  arr[del] = edit + "\n"

  puts "contact edited succesfully"
  puts "\n"
  Menu()


  File.open('data.json', 'w') {|file| file.truncate(0) }

  aFile = File.new("data.json", "a")
  arr.each do |vals|
    if aFile
        aFile.syswrite(vals)
    else
          puts "Unable to open file!"
          puts "\n"

    end
  end
end
end



  end
end


rescue Exception => e
  puts "Edit Error"
end
end

def edit_fname(firstname, hsh_contact)
if firstname == ""
  hsh_contact["firstname"]
else
  firstname
end
end

def edit_lname(surname, hsh_contact)
if surname == ""
  hsh_contact["surname"]
else
  surname
end
end

def edit_pnum(phoneNumber, hsh_contact)
if phoneNumber == ""
  hsh_contact["phoneNumber"]
else
  phoneNumber
end
end


def ViewContact
  begin

  puts "Saved Contacts"
  counter = 1
file = File.new("data.json", "r")
while (line = file.gets)
data = JSON.parse(line)
puts "#{counter}. Name: #{data["firstname"]} #{data["surname"]}"
puts "Phone Number #{data["phoneNumber"]}"

  counter = counter + 1
end
  file.close
  puts "\n"

  Menu()

end

  rescue Exception => e
  puts "Error"
  end


def DeleteContact
  begin

  puts "\n"
  puts "Delete Contact"
  file = File.open("data.json").readlines
  details = []
file.each  { |items|
details << JSON.parse(items)
  }

  details.each_with_index do |hsh,index|
puts "#{index+1}. #{hsh["firstname"]}, #{hsh["surname"]} :: #{hsh["phoneNumber"]} \n"
end

  puts "Please select contact you want to delete."
  STDOUT.flush
  selection = gets.chomp
  if !/\A\d+\z/.match(selection)
      puts "selection is invalid, please try again"
  else
      selection = selection.to_i
      delete_this = selection - 1
      puts "To delete contact"
      puts "Press 1 to DELETE or 2 to Cancel \n"
      STDOUT.flush
      confirm = gets.chomp
      if confirm == "1"
          delete(delete_this)
          puts "contact has been deleted successfully"
          puts "\n"
          Menu()

      else
          puts"Delete unsuccessful"
          puts "\n"
          Menu()
      end
    end

  rescue Exception => e
    puts "Error"

  end
end

# delete contact
def delete(input)
  count = 0
  myedit =""

  File.open('data.json').each do |line|
      if count != input
      myedit = myedit + line
      end
      count +=1
  end

  File.open("data.json", "w") do |thisfile|
      thisfile.write(myedit)
  end


end

def Menu
  begin

    puts "ADDRESS BOOK"
    puts "1. Add Contact"
    puts "2. Edit Contact"
    puts "3. View Contact"
    puts "4. Delete Contact"

    puts "Please Select from the above options"

    response1 = gets.chomp()
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

  rescue Exception => e
    puts "Error"


  end
end
