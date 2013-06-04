class Mark < ActiveRecord::Base
  before_save :set_default_zero
  
  def set_default_zero
    if student_mark == nil
        self.student_mark = 0
    end
  end  
  
end
