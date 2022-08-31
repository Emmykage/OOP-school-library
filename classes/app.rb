require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'classroom'
require_relative 'preserve_file'
require 'json'
class App
  attr_reader :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
    @store_file = PreserveFile.new
    load_people
    load_books
    load_rentals
  end

  def load_people
    stored_people = @store_file.read_json('data/person.json')
    # classroom = 'default'
    stored_people.map do |person|
      case person['type']
      when 'student'
         @persons << Student.new(person['age'], person['classroom'], person['name'], person['id'], parent_permission: person['permission'])
      when 'teacher'
         @persons << Teacher.new(person['age'], person['specialization'], person['name'], person['id'])
    
        end
      end
    
  end

  def load_books
    
      stored_books = @store_file.read_json('data/book.json')
      stored_books.map do |book|
               @books.push(Book.new(book['title'], book['author']))
      end
  end

  def load_rentals
        stored_rental = @store_file.read_json('data/rent.json')
        stored_rental.each do |rental|
          # p rental['date']
        
      filtered_person = @persons.find {|person| rental['name'] == person.name}
      filtered_book = @books.find {|book| rental['book_tile'] == book.title}
       @rentals.push(Rental.new(rental['date'], filtered_book, filtered_person))
      end
   
  end

  
  def add_rent_data
    rental_collection = @rentals.map do | rental |
      {date: rental.date, person_id: rental.person.id, name: rental.person.name, book_title: rental.book.title}
    end
    @store_file.save_to_json(rental_collection, 'data/rent.json')
  end

  def add_people_data
    people_collection = @persons.map do |person|
      if person.instance_of?(Student)
        { type: 'student', id: person.id, age: person.age, name: person.name, parent_permission: person.parent_permission }
      else
        { type: 'teacher', id: person.id, age: person.age, name: person.name, specialization: person.specialization }
      end
    end
    @store_file.save_to_json(people_collection, 'data/person.json')
  end

  def add_book_data
    book_collection = @books.map do |book|
      { title: book.title, author: book.author, id: book.id }
    end
    @store_file.save_to_json(book_collection, 'data/book.json')
  end

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

  def create_student
    puts "Enter a student\'s name"
    name = gets.chomp

    puts "Enter student\'s age"
    age = gets.chomp.to_i

    permission = permission?

    classroom='default'

    @persons.push(Student.new(age, classroom,  name, parent_permission: permission))


    add_people_data

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
    name = gets.chomp

    puts "Enter teacher\'s age"
    age = gets.chomp.to_i

    puts 'Enter specialization'
    special = gets.chomp

    @persons.push(Teacher.new(age, special, name))
    add_people_data

    puts 'Teacher has been created'
  end

  def create_book
    puts 'Enter Book Title'
    title = gets.chomp
    puts 'Enter Book author'
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'book has been created'
    add_book_data
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
    if @books.include? @books[book_selection]

      puts "#{@books[book_selection]} has been selected"

      puts 'Select person'
      @persons.each_with_index { |person, index| puts "[#{index}] ->#{person.name} ID: #{person.id}" }
      person_selection = gets.chomp.to_i

      puts 'Enter date for rental YYYY-MM-DD'
      r_date = gets.chomp

      @rentals.push(Rental.new(r_date, @books[book_selection], @persons[person_selection]))
      puts "#{persons[person_selection].name} with #{persons[person_selection].id}rentals has been created"
    else
      'Enter a valid input'
    end
    add_rent_data
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
