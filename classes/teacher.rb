require_relative 'person'
class Teacher < Person
  attr_accessor :specialization

  def initialize(age, specialization, name = 'unknown', id = Random.rand(1..10_000), parent_permission: true)
    super(age, name, id, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_service?
    true
  end
end
