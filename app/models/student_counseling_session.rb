class StudentCounselingSession < ActiveRecord::Base
  # relationships, validations, controller searches, variables, lists, relationship checking
  belongs_to :student
  #belongs_to :created_by, :polymorphic => true,  :foreign_key => 'created_by'
  
  validates_presence_of :student_id
  
  
  def self.find_appointment(search)
    if search
      find(:all, :include => :student, :conditions => ['requested_at > ? AND students.name ILIKE ?', Time.now, "%#{search}%" ], :order => 'confirmed_at DESC')
    else
      find(:all, :include => :student, :conditions => ['requested_at > ?', Time.now ], :order => 'confirmed_at DESC')
    end
  end
  
  def self.find_session_done(search)
    if search
      find(:all, :include => :student, :conditions => ['confirmed_at < ? AND students.name ILIKE ?', Time.now, "%#{search}%" ], :order => 'confirmed_at DESC')
    else
      find(:all, :include => :student, :conditions => ['confirmed_at < ?', Time.now ], :order => 'confirmed_at DESC')
    end
  end
  

  
end
