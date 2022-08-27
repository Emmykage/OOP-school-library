require_relative 'student"'
require_relative 'classroom'

require_relative 'book'
require_relative 'rental'

femi = Student.new(6, 'femi')
temi = Student.new(7, 'temitope')
david = Student.new(6, 'david')
golo = Person.new(27, 'Timothy')

nania = Book.new('CHRONICLES PF NANIA', 'ROWLINGS')
Rental.new('2022-08-25', nania, golo)

classone = Classroom.new('classone')
classtwo = Classroom.new('classtwo')

# p david.classy

classone.add_student(femi)
classone.add_student(david)

p david.classroom

classtwo.add_student(temi)

p classone.students.count

# p classone.students
