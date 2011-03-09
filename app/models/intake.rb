class Intake < ActiveRecord::Base
  before_save :save_my_vars
  
  has_many :intakename,    :class_name => 'period_timing',    :foreign_key => 'intake_id'   #Link to Period_timing
  has_many :intake,        :class_name => 'time_table_entry', :foreign_key => 'intake_id'   #Link to Time Table Entry
  has_many :intakeclass,   :class_name => 'klass',            :foreign_key => 'intake_id'   #Link to Class
  has_many :intakestudent, :class_name => 'Student',          :foreign_key => 'intake_id'  #Link to Student

  validates_presence_of :intake_no, :year
  validates_uniqueness_of :intake_no, :scope => [:year], :message => "This intake already exists"
  
  def save_my_vars
    self.name = make_intake_name
  end
  
  def make_intake_name
    a = (intake_no).to_s
    b = year.strftime("%Y").to_s
    "#{a}"+"/"+"#{b}"
  end
  
  def intake_month_map
    (Intake::INTAKE_MONTH.find_all{|disp, value| value == intake_no}).map {|disp, value| disp}
  end
  
  
  
  INTAKE_MONTH = [
                #  Displayed       stored in db
                [ "January",      1 ],
                [ "July",         2 ]
  ]

end