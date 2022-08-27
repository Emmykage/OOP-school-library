require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
class App
  attr_reader :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
  end
  puts 'Select an option'

  def list_people
    if @persons.empty?
      puts 'no person added '
    else
      @persons.each { |person| puts("name: #{person.name}") }
    end
  end

  def list_books
    if @books.empty?
      puts 'book list is empty'
    else
      @books.each { |book| puts "Title: #{book.title} Author: #{book.author}" }
    end
  end

  def create_person
    puts "Create a Teacher or a Student
        [1] -> Student
        [2] -> Teacher
        "
    pick = gets.chomp.to_i

    case pick
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Enter a valid input'
      create_person
    end
  end

  def create_student
    puts "Enter a student\'s name"
    s_name = gets.chomp

    puts "Enter student\'s age"
    s_age = gets.chomp.to_i

    permission = permission?

    @persons.push(Student.new(s_age, s_name, parent_permission: permission))

    @books.each { |e| puts e.title }

    puts 'student created'
  end

  def permission?
    puts 'Do you have parents permission? [Y/N]'
    permit = gets.chomp.downcase
    case permit
    when 'y'
      true
    when 'n'
      false
    else
      puts 'enter a valid response'

    end
  end

  def create_teacher
    puts "Enter teacher\'s name"
    t_name = gets.chomp

    puts "Enter teacher\'s age"
    t_age = gets.chomp.to_i

    puts 'Enter specialization'
    t_special = gets.chomp

    @persons.push(Teacher.new(t_age, t_special, t_name))

    puts 'Teacher has been created'
  end

  def create_book
    puts 'Enter Book Title'
    title = gets.chomp
    puts 'Enter Book author'
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'book has been created'

    @books.each { |book| puts("name: #{book.title} #{book.author}") }
  end

  def create_rental
    puts 'Select a book by index'
    if @books.empty?
      puts 'no books available'
    else
      @books.each_with_index { |book, index| puts "[#{index}]-> Title: #{book.title} Author: #{book.author}" }
      puts 'select ID'

    end

    book_selection = gets.chomp.to_i
    puts "#{@books[book_selection]} has been selected"

    puts 'Select person'
    @persons.each_with_index { |person, index| puts "[#{index}] ->#{person.name} ID: #{person.id}" }
    person_selection = gets.chomp.to_i
    puts "#{@persons[person_selection]} was selected"

    puts 'Enter date for rental YYYY-MM-DD'
    r_date = gets.chomp

    @rentals.push(Rental.new(r_date, @books[book_selection], @persons[person_selection]))
    puts "#{persons[person_selection].name} with #{persons[person_selection].id}rentals has been created"
  end

  def list_rental
    if @rentals.empty?
      puts 'There are no rentals'
    else
      puts 'Enter persons id'
      p_id = gets.chomp.to_i

      person_rental = @rentals.select { |rental| rental.person.id == p_id }

      puts 'no books for selected ID' if person_rental.empty?
      person_rental.each { |e| puts "Name: #{e.person.name}  -> Book: #{e.book.title} -> #{e.book.author}" }
    end
  end

  def quit_app
    puts 'Thanks for using our app'
  end
end
