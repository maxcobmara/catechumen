class Appraisal < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, controller searches, variables, lists, relationship checking
  
  before_save :varmyass
  
  belongs_to :appraisedstaff, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :ppp, :class_name => 'Staff', :foreign_key => 'ppp_id'
  
  has_many :evactivities, :dependent => :destroy
  accepts_nested_attributes_for :evactivities, :reject_if => lambda { |a| a[:evactivity].blank? }
  
  has_many :ptdos, :through => :appraisedstaff
  
  #e.g
  #has_many :qualifications, :dependent => :destroy
  #accepts_nested_attributes_for :qualifications, :reject_if => lambda { |a| a[:level_id].blank? }

  validates_presence_of :staff_id
  
  def varmyass
    self.ppptotals	= ppptotal
    self.ppktotals	= ppktotal
    self.ppppercent	= pppperc
    self.ppkpercent	= ppkperc
    self.pointsaverage = ppaverage
  end
  
  # save calculations for ppp
    
  def ppptotal
    pppquantity + pppquality + pppontime + pppeffective + 
    pppknowledge + ppprules + pppcommunication +
    pppleader + pppmanage + pppdiscipline + pppproactive + ppprelate + 
    pppparttwo
  end
  
  def ppktotal
    ppkquantity + ppkquality + ppkontime + ppkeffective + 
    ppkknowledge + ppkrules + ppkcommunication +
    ppkleader + ppkmanage + ppkdisipline + ppkproactive + ppkrelate + 
    ppkparttwo
  end
  
  def pppperc
    (((pppquantity + pppquality + pppontime + pppeffective)/100)*50) +
    (((pppknowledge + ppprules + pppcommunication)/100)*20) +
    (((pppleader + pppmanage + pppdiscipline + pppproactive + ppprelate)/100)*20) +
    (((pppparttwo)/100)*10)
  end
  
  def ppkperc
    (((ppkquantity + ppkquality + ppkontime + ppkeffective)/100)*50) +
    (((ppkknowledge + ppkrules + ppkcommunication)/100)*20) +
    (((ppkleader + ppkmanage + ppkdisipline + ppkproactive + ppkrelate)/100)*20) +
    (((ppkparttwo)/100)*10)
  end
  
  def ppaverage
    (pppperc + ppkperc)/2
  end
  
  def appraisedstaff_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "MyKad No Longer Exists" 
       else
         appraisedstaff.formatted_mykad
       end
  end
  
  def staffname_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "Staff No Longer Exists" 
       else
         appraisedstaff.name
       end
  end
  
  def staffname_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "Staff No Longer Exists" 
       else
         appraisedstaff.name
       end
  end
  
  def position_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "Position No Longer Exists" 
       else
         appraisedstaff.position_for_staff
       end
  end
  
end
