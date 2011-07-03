class Appraisal < ActiveRecord::Base
  
  before_save :varmyass
  
  belongs_to :appraisedstaff, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :ppp, :class_name => 'Staff', :foreign_key => 'ppp_id'
  
  has_many :evactivities, :dependent => :destroy
  has_many :ptdos, :through => :appraisedstaff
  accepts_nested_attributes_for :evactivities

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
  
end
