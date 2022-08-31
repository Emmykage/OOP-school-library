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
    stored_people.map do |p|
      case p['type']
      when 'student'
        @persons << Student.new(p['age'], p['classroom'], p['name'], p['id'], parent_permission: p['permission'])
      when 'teacher'
        @persons << Teacher.new(p['age'], p['specialization'], p['name'], p['id'])

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
      person = @persons.find { |p| p.id == rental['person_id'] }
      book = @books.find { |b| b.title == rental['book_title'] }
      @rentals.push(Rental.new(rental['date'], book, person))
    end
  end

  def add_rent_data
    rental_collection = @rentals.map do |r|
      { date: r.date, person_id: r.person.id, name: r.person.name, book_title: r.book.title, book_id: r.book.id }
    end
    @store_file.save_to_json(rental_collection, 'data/rent.json')
  end

  def add_people_data
    people_collection = @persons.map do |person|
      if person.instance_of?(Student)
        { type: 'student', id: person.id, age: person.age, name: person.name,
          parent_permission: person.parent_permission }
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
      @persons.each_with_index { |person, index| puts "[#{index}] ->#{person.name} ID: #{person.id}" }
    end
  end

  def list_books
    if @books.empty?
      puts 'book list is empty'
    else
      @books.each_with_index { |book, index| puts "[#{index}]-> Title: #{book.title} Author: #{book.author}" }
    end
  end

  def create_student
    puts "Enter a student\'s name"
    name = gets.chomp

    puts "Enter student\'s age"
    age = gets.chomp.to_i

    permission = permission?

    classroom = 'default'

    @persons.push(Student.new(age, classroom, name, parent_permission: permission))

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
    list_books
    puts 'select ID'

    book_selection = gets.chomp.to_i
    if @books.include? @books[book_selection]

      puts "#{@books[book_selection]} has been selected"

      puts 'Select person'
      list_people
      person_selection = gets.chomp.to_i

      puts 'Enter date for rental YYYY-MM-DD'
      r_date = gets.chomp
      @rentals.push(Rental.new(r_date, @books[book_selection], @persons[person_selection]))
      puts "#{persons[person_selection].name} with #{persons[person_selection].id} rentals has been created"
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
