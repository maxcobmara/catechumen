class StudentCounselingSession < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_to_nil_where_false
  
  belongs_to :student
  belongs_to :student_discipline_case, :foreign_key => 'case_id'
  #belongs_to :created_by, :polymorphic => true,  :foreign_key => 'created_by'
  
  validates_presence_of :student_id
  
  attr_accessor :feedback,:feedback_this, :feedback_final
  
  #before logic
  def set_to_nil_where_false
    if is_confirmed == false
      self.confirmed_at= nil
    end
  end
  
  def self.find_appointment(search)
    if search
      find(:all, :include => :student, :conditions => ['requested_at > ? AND (students.name ILIKE ? OR students.matrixno ILIKE ?)', Time.now.in_time_zone('UTC'), "%#{search}%", "%#{search}%"], :order => 'requested_at DESC')
    else
      find(:all, :include => :student, :conditions => ['requested_at > ?', Time.now.in_time_zone('UTC') ], :order => 'requested_at DESC')
    end
  end
  
  def self.find_session_done(search)
    if search
      find(:all, :include => :student, :conditions => ['confirmed_at < ? AND (students.name ILIKE ? OR students.matrixno ILIKE ?)', Time.now.in_time_zone('UTC'), "%#{search}%", "%#{search}%" ], :order => 'confirmed_at DESC')
    else
      find(:all, :include => :student, :conditions => ['confirmed_at < ?', Time.now.in_time_zone('UTC') ], :order => 'confirmed_at DESC')
    end
  end
  
  def self.get_start_date(y,m,d)
    startdate=DateTime.new(y.to_i,m.to_i,d.to_i,0,0,0)  if y!="" && m!="" && d!=""
  end
  
  def self.get_end_date(y2,m2,d2)
    enddate=(DateTime.new(y2.to_i,m2.to_i,d2.to_i,0,0,0)+1.days)  if y2!="" && m2!="" && d2!=""
  end
  
  def self.search_appointment(startdt,enddt)
    startdte=startdt.strftime('%Y-%m-%d %H:%M:%S')
    enddte =enddt.strftime('%Y-%m-%d %H:%M:%S') 
    find(:all, :conditions =>['requested_at>? and requested_at<? and requested_at >?', startdte, enddte, Time.now.in_time_zone('UTC') ],:order => 'requested_at DESC')
  end 
  
  def self.search_session_done(startdt,enddt)
      startdte=startdt.strftime('%Y-%m-%d %H:%M:%S')
      enddte =enddt.strftime('%Y-%m-%d %H:%M:%S') 
      find(:all, :conditions =>['requested_at>? and requested_at<? and confirmed_at <?', startdte, enddte, Time.now.in_time_zone('UTC') ], :order => 'confirmed_at DESC')
  end 
  
end
