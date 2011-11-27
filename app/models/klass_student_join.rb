class KlassStudentJoin < ActiveRecord::Base
  has_many :students
  has_many :klasses
end
