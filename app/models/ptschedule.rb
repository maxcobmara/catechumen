class Ptschedule < ActiveRecord::Base
  belongs_to :ptcourse
  validates_presence_of :ptcourse_id, :message => "Please Select Course"
  validates_presence_of :start, :location, :min_participants, :max_participants
  has_many :ptdos, :dependent => :destroy
end
