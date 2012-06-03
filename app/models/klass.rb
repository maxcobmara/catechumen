class Klass < ActiveRecord::Base
  
  has_many :timetables
  #belongs_to :intakeclass,  :class_name => 'Intake', :foreign_key => 'intake_id'
     
  belongs_to :programme
  belongs_to :subject
  has_and_belongs_to_many :students
  
  def self.ddfilter(ddfilter)
    if ddfilter == nil
    elsif ddfilter != '0'
        @klasses = Klass.find(:all, :conditions => ["programme_id=?", ddfilter ])
    else
      @klasses = Klass.find(:all)
    end
  end
  

   
end
