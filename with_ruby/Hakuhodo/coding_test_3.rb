class Person < ActiveRecord::Base
  belong_to :person
  has_many :person, foregin_key: :person_id, dependent: :nullfy
end


irb(main):001:0> robert = Person.create(name: "Robert")
irb(main):002:0> tim = Person.create(name: "Tim", parent: robert)
irb(main):003:0> bob = Person.create(name: "Bob", parent: robert)
irb(main):004:0> robert.children.map(&:name)
=> ["Tim", "Bob"]