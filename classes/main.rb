require_relative 'app'
app = App.new()
def main(app)
   
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

        key_select(option, app)
    end
    

    def key_select(option, app)
        
       
        case option
        when 1
            app.list_books
            display(app)
          
        when 2
            app.list_people
            display(app)
        when 3
            app.create_person
            display(app)
        when 4 
            app.create_book
            display(app)
        when 5 
            app.create_rental
            display(app)
        when 6
            app.list_rental
            display(app)
        when 7
            app.quit_app
          
        else
            puts 'enter valid input'
        end
    end
    
    display(app)

end
main(app)