class SktStaff < ActiveRecord::Base
  belongs_to :pyd, :class_name => 'Staff', :foreign_key => 'pyd_id'
   belongs_to :ppp,     :class_name => 'Staff', :foreign_key => 'ppp_id'
  
   before_save :save_my_ppp
   
  has_many :skt_targets, :dependent => :destroy
  accepts_nested_attributes_for :skt_targets, :reject_if => lambda { |a| a[:activity].blank? }, :allow_destroy =>true
 
  def save_my_ppp
   self.ppp_id = pyd.position.bosses.staff_id
  end
 
  def bil
     v=1
  end
 
end
