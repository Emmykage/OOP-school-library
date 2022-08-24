require_relative './nameable'
require_relative './base_decorator'
require_relative './capitalize_decorator'
require_relative './trimmer_decorator'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..10_000)

    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_service?
    return true if of_age? || @parent_permission

    false
  end

  def correct_name
    @name
  end

  private

  def of_age?
    return false if @age < 18

    true if @age >= 18
  end
end

person = Person.new(22, 'maximilianus')
p person
p person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
p capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
p capitalized_trimmed_person.correct_name

# p1 = Person.new('morris', 27)
# p1.can_use_service?
# p p1
