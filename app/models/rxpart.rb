class Rxpart < ActiveRecord::Base
  belongs_to :part
  validates_presence_of :lponum
end
