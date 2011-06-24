class Ptschedule < ActiveRecord::Base
  belongs_to :ptcourse
  validates_presence_of :ptcourse_id
  has_many :ptdos
end
