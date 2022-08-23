class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_service?
    return true if of_age? || @parent_permission

    false
  end

  private

  def of_age?
    return false if @age < 18

    true if @age >= 18
  end
end

p1 = Person.new('morris', 27)
p1.can_use_service?
p p1
