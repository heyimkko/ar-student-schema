require_relative '../../db/config'
require 'date'
require 'faker'

class Student < ActiveRecord::Base
  has_one :teacher

  validates :email, :format => { :with => /^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$/, 
                                 :message => "Not valid e-mail" }
  validates :email, :uniqueness => true
  validate :age_must_be_greater_than_5
  validates :phone, :length => { :minimum => 10 }
  validates :phone, :format => { :with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/,
                                 :message => "Not valid phone number" }

  def age_must_be_greater_than_5
    now = Date.today
    age = now.year - birthday.year - ((now.month > birthday.month ||
                                       (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
    if age < 5
      errors.add(:birthday, "Users under 5 not allowed.")
    end
  end

  def name
    first_name + ' ' + last_name
  end

  def age
    now = Date.today
    age = now.year - birthday.year - ((now.month > birthday.month ||
                                       (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end
end




# 100.times do Student.create(  :first_name => Faker::Name.first_name,
#                               :last_name => Faker::Name.last_name,
#                               :phone => '412-345-6789', 
#                               :email => Faker::Internet.email,
#                               :birthday => Date.new(1989,9,24),
#                               :gender => 'male',
#                               :teacher_id => rand(1..10)
#                               )
# end

# p Student.where('first_name = ?', 'Augustus')

p Student.where('teacher_id = ?', 4)
