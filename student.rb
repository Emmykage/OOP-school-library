require "./person"

class Student < Person
  def initialize(classroom)
    super(name, age, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    return "¯\(ツ)/¯"
  end
end