class Ptschedule < ActiveRecord::Base
  belongs_to :ptcourse
  validates_presence_of :ptcourse_id, :message => "Please Select Course"
  validates_presence_of :start, :location, :min_participants, :max_participants
  has_many :ptdos, :dependent => :destroy
  
  def enddate
    duration=Ptdo.staff_course_days(Ptcourse.find(ptcourse_id))
    bal_hours = duration % 6
    days_count = duration / 6
    if bal_hours >= 3                 #6 hours=1 day
      duration=days_count+1
    end
    start+duration.to_i.day
  end
  
  def self.search(search)
    if search
      searched_ptcourses_ids=Ptcourse.find(:all, :conditions =>['name ILIKE (?)', "%#{search}%"]).map(&:id)
      ptschedules=Ptschedule.find(:all, :conditions => ['ptcourse_id IN(?) or location ILIKE (?)', searched_ptcourses_ids,"%#{search}%"])
    else
      ptschedules=Ptschedule.find(:all, :order => "start DESC")
    end 
    ptschedules
  end
  
  ###removed from ptdo - 26May2015
  def self.all2
    ptschedule_ids = Ptdo.find(:all, :conditions => ['trainee_report is not null']).map(&:ptschedule_id)
    Ptschedule.find(:all, :conditions => ['budget_ok=? and id IN(?)', true, ptschedule_ids], :order => 'start DESC') 
  end
  
  def self.filters
    filtering=[{:scope => "all2", :label => I18n.t('ptschedule.all_records')}]
    Ptschedule.all2.group_by{|x|x.start.strftime("%Y")}.each do |year2, ptschedules|
      filtering << {:scope=>"#{year2}", :label =>"#{year2}"}
    end
    filtering
  end
  
  PAYMENT=[
    #  Displayed       stored in db
    [I18n.t('ptschedule.local_order'), 1],
    [I18n.t('ptschedule.cash'), 2]
  ]
  
  def render_payment
    (Ptschedule::PAYMENT.find_all{|disp, value| value == payment}).map{|disp, value| disp}
  end
  ###
  
end
