class Ptdo < ActiveRecord::Base
  before_save  :whoami
  
  belongs_to  :ptschedule
  belongs_to  :staff
  
  def whoami
    self.staff_id = User.current_user.staff_id
    self.ptcourse_id = ptschedule.ptcourse.id
  end
end
