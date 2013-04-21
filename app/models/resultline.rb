class Resultline < ActiveRecord::Base
  belongs_to :examresult, :foreign_key => 'examresult_id'
  belongs_to :student, :foreign_key => 'student_id'
  validates_presence_of :student_id, :total, :pngs17, :status   #total (keep first)==>value obtained from grade.rb-> works like total_marks (previously be4 changed to virtual attr) -> changes does not take effect on 1st edit
                                                                #total refers to sum of.. [(set_NG*credit hour)..of each subject]
  def render_status
    (Resultline::STATUS.find_all{|disp, value| value == status}).map {|disp, value| disp}
  end
  
  STATUS =[
            #  Displayed       stored in db
            [ "Lulus", "1"],
            [ "Gagal", "2"],
  ]
end
