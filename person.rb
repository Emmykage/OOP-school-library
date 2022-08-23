class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(name = "Unknown", age, parent_permission: true)
    @id = Random.rand(1..10000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_service?
    if is_of_age? || @parent_permission
      return true
    end
  end

  private

  def is_of_age?
    if @age >= 18
      return true
    else
      return false
    end
  end
end

p1 = Person.new('morris', 27)
p1.can_use_service?
p p1
