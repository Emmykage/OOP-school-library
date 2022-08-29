require_relative 'app'

def display(app)
    puts "
      [1] -> List all books
      [2] -> List all people
      [3] -> Create a person
      [4] -> Create a book
      [5] -> Creat a rental
      [6] -> List all rentals for a given person id
      [7] -> quit
      Enter Selection:
      "
    option = gets.chomp.to_i
    process = Operation.new()
    process.key_select(option, app)
end

class Operation 

    puts 'Select an option'
# rubocop:disable Metrics/CyclomaticComplexity
def key_select(option, app)
    case option
    when 1
     list_books(app)
  
    when 2
     list_people
  
    when 3
    create_person(app)
  
    when 4
      app.create_book
  
    when 5
      app.create_rental
  
    when 6
      app.list_rental
  
    when 7
      app.quit_app
    else
      puts 'enter valid input'
    end
    display(app) if option < 7
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def list_book(app)
    app.list_books

  end

  def list_people(app)
    app.list_people

  end

  def create_person(app)
    puts "Create a Teacher or a Student
    [1] -> Student
    [2] -> Teacher
    "
    pick = gets.chomp.to_i
    case pick
    when 1
        app.create_student
    when 2
        app.create_teacher
    else
        puts 'Enter a valid input'
        create_person
    end
  end


end