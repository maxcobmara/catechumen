class StudentMark < ActiveRecord::Base
  
  before_save :varmyass
  
  belongs_to :Analysisgrade
  belongs_to  :student_name, :class_name => 'Student',   :foreign_key => 'student_id'
  
  def varmyass
    self.total_mark	= totalresultexam
  end
  
  def totalresultexam
    m_1 + m_2 + m_3 + m_4 + m_5 + m_6 + m_7 + m_8 + m_9 + m_10 +
    m_11 + m_12 + m_13 + m_14 + m_15 + m_16 + m_17 + m_18 + m_19 +
    m_20 + m_21 + m_22 + m_23 + m_24 + m_25 + m_26 + m_27 + m_28 +
    m_29 + m_30 + m_31 + m_32 + m_33 + m_34 + m_35 + m_36 + m_37 + m_38
  end
end
