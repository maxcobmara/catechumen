class Klass < ActiveRecord::Base
  
  has_many :timetables
  #belongs_to :intakeclass,  :class_name => 'Intake', :foreign_key => 'intake_id'
     
  belongs_to :programme
  belongs_to :subject
  has_and_belongs_to_many :students
  
  #-------- 24 Apr 2012 ----------for search by programme
  def self.search2(search2)
     if search2 
       if search2 != '0'
         @klasses = Klass.find(:all, :conditions => ["programme_id=?", search2 ])
       else
         @klasses = Klass.find(:all)
       end
     else
       @klasses = Klass.find(:all)
     end
  end
  #-------- 24 Apr 2012 ----------for search by programme
  #-------- 24 Apr 2012 ----------for search by class name
  def self.search(search)
     if search
      @klass = Klass.find(:all, :conditions => ["name ILIKE ?","%#{search}%"])
     else
      @klass = Klass.find(:all)
     end
  end
 #-------- 24 Apr 2012 ----------
   
end
