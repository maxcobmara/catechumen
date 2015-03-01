class TravelRequest < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_to_nil_where_false, :set_total, :set_mileage_nil_when_not_own_car
  
  belongs_to :applicant,    :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :replacement,  :class_name => 'Staff', :foreign_key => 'replaced_by'
  belongs_to :headofdept,   :class_name => 'Staff', :foreign_key => 'hod_id'
  
  belongs_to :travel_claim
  belongs_to :document
  
  validates_presence_of :staff_id, :destination, :depart_at, :return_at
  validates_presence_of :own_car_notes, :if => :mycar?
  validate :validate_end_date_before_start_date, :staff_vehicle_must_exist_if_own_car
  validates_presence_of :replaced_by, :if => :check_submit?
  validates_presence_of :hod_id, :if => :check_submit?
  
  has_many :travel_claim_logs, :dependent => :destroy
  accepts_nested_attributes_for :travel_claim_logs, :reject_if => lambda { |a| a[:destination].blank? }, :allow_destroy =>true
  
  attr_accessor :staff_own_car, :tpt_class
  
  #before logic
  def set_to_nil_where_false
    if is_submitted == true
      self.submitted_on = Date.today
      if mileage == true
        self.mileage_history = 1
      elsif mileage == false
        self.mileage_history = 2
      end
    end

    if hod_accept == false
      self.hod_accept_on	= nil
    end
    
    if !mycar? #own_car == false 
      self.own_car_notes =''
      self.mileage = nil
    end
    
    #decision by hod - mileage_replace field only appear in approval page
    if mileage_replace == false 
      self.mileage = true
    elsif mileage_replace == true && self.mileage!=false #after '&&' - required - or error will arise (repetive)
      self.mileage = false
    end
  end
  
  def set_mileage_nil_when_not_own_car
    #true for mileage allowance
    #false for mileage replacement
    unless own_car
      self.mileage_replace = nil
    end
  end
  
  def set_total
    self.log_mileage = total_mileage_request
    self.log_fare = total_km_money_request
  end

  #validation logic
  def validate_end_date_before_start_date
    if return_at && depart_at
      errors.add(:depart_at, "You must leave before you return") if return_at < depart_at
    end
  end
  
  def staff_vehicle_must_exist_if_own_car
    if own_car == true &&  Login.current_login.staff.vehicles.count==0
      errors.add(I18n.t('vehicles.title'), I18n.t('travel.vehicle_must_exist'))
    end
  end
  
  def mycar?
    own_car == true
  end
  
  def check_submit?
    is_submitted == true
  end
  
  def requires_approval
    if hod_accept == nil && hod_id == Login.current_login.staff_id
      (link_to image_tag("approval.png", :border => 0), :action => 'edit', :id => travel_request).to_s
    elsif is_submitted == true && hod_accept == nil && staff_id == Login.current_login.staff_id
      ""
    elsif is_submitted == false || is_submitted == nil
      (link_to image_tag("edit.png", :border => 0), :action => 'edit', :id => travel_request).to_s
    else
    end
  end
  
  #controller searches
  def self.in_need_of_approval
    find(:all, :conditions => ['hod_id = ? AND is_submitted = ? AND (hod_accept IS ? OR hod_accept = ?)', Login.current_login.staff_id, true, nil, false],:order=> 'depart_at asc')
  end
  
  def self.my_travel_requests
      find(:all, :conditions => ['staff_id = ?', Login.current_login.staff_id], :order=> 'depart_at asc')
  end
  
  #lists
  def document_refno
    document.refno if document
  end
  
  def document_refno=(refno)
    self.document = Document.find_by_refno(refno) unless refno.blank?
  end
  
  #ref:gmail-sept15,2012-Checking for broken association - refer document.rb (line 17), index-line 69, show_main-line 13
  def reference_document
    if document.blank?
      "None Assigned"
    else
      document.refno+" : "+document.title+" : dated "+document.letterdt.strftime("%d-%b-%Y").to_s
    end
  end
  
  def repl_staff
    unit_name = Login.current_login.staff.position.unit
    siblings = Position.find(:all, :conditions=>['unit=?', unit_name]).map(&:id)
    #children = Login.current_login.staff.position.child_ids
    possibles = siblings #+ children #not suitable for Pn Nabilah, Pn Rokiah - Timbalan2 Pengarah
    replacements = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", possibles]).map(&:staff_id)
    replacements
  end
  
  def hods
#     previous one - BEFORE 1st March 2015 - start
#     unit_name = Login.current_login.staff.position.unit
#     applicant_post= Login.current_login.staff.position
#     prog_names = Programme.roots.map(&:name)
#     #common_subjects = Programme.find(:all, :conditions=>['course_type=?', "Common Subject"]).map(&:name)  #no yet exist in programme & name format not sure 2
#     common_subjects=["Komunikasi & Sains Pengurusan", "Sains Tingkahlaku", "Anatomi & Fisiologi", "Sains Perubatan Asas"]
#     approver=[]
#     if prog_names.include?(unit_name) || unit_name == "Pos Basik" || common_subjects.include?(unit_name)
#       if applicant_post.tasks_main.include?("Ketua Program") || applicant_post.tasks_main.include?("Ketua Subjek")
#         approver = Login.current_login.staff.position.parent.staff_id
#       else
#         sib_pos = Position.find(:all, :conditions=>['unit=? and staff_id is not null',unit_name], :order=>('combo_code ASC'))
#         if sib_pos
#           sib_pos.each do |sp|
#             approver << sp.staff_id if sp.tasks_main.include?("Ketua Program") || sp.tasks_main.include?("Ketua Subjek")
#           end
#         end        
#       end
#     else
#       #kskb server - yg penuhi syarat di bawah - position kosong no staff being assigned
#       staffapprover = Position.find(:all, :conditions=>['unit=? and combo_code<? and ancestry_depth!=?', unit_name, applicant_post.combo_code,1]).map(&:staff_id)
#       #Above : ancestry_depth!= 1 to avoid Timbalan2 Pengarah - fr becoming each other's hod.
#       approvers= Staff.find(:all, :conditions=>['id IN(?)', staffapprover])
#       approvers.each_with_index do |ap,idx|
#         approver << ap.id if ap.staffgrade.name.scan(/\d+/).first.to_i > 26  #check if approver really qualified one 
#       end
#       approver << Login.current_login.staff.position.parent.staff_id if approver.compact.count==0          #just in case approver=[nil]
#       approver << Login.current_login.staff.position.ancestors.map(&:staff_id) if approver.compact.count==0
#     end
#     #override all above approver - 23Dec2014 - do not remove above yet, may be useful for other submodules
#     hod_posts = Position.find(:all, :conditions=>[ 'ancestry_depth<?',2])
#     approver=[] 
#     hod_posts.each do |hod|
#       approver << hod.staff_id if (hod.name.include?("Pengarah")||(hod.name.include?("Timbalan Pengarah")) && hod.staff_id!=nil)
#     end
#     approver
#     previous one - BEFORE 1st March 2015 - end
    
    #from Travel Request (new format) - start**************************************************************************
    applicant_unit = applicant.position.unit
    applicant_grade = applicant.staffgrade.name[-2,2]
    unit_members=Position.find(:all, :joins => :staff, :conditions =>['unit=? and positions.name!=?', applicant_unit, "ICMS Vendor Admin"], :order => "ancestry_depth ASC")
    
    if Programme.roots.map(&:name).include?(applicant_unit)
      #Academician--start---
      highest_rank = unit_members.sort_by{|x|x.staffgrade.name[-2,2]}.last
      highest_grade = highest_rank.staffgrade.name[-2,2]
      maintasks = applicant.position.tasks_main  
      if maintasks.include?("Ketua Program") 
        approver1 =  Position.find(:first, :conditions => ['name=?', "Timbalan Pengarah Akademik (Pengajar)"]).staff_id
      elsif maintasks.include?("Ketua Teras")
	if highest_grade > applicant_grade #kp exist
	  approver1 = highest_rank.staff_id 
	else #kp not exist - die ketua prog (tanggung tugas)
	  approver1 =  Position.find(:first, :conditions => ['name=?', "Timbalan Pengarah Akademik (Pengajar)"]).staff_id
	end
      else #pengajar
        app=0
	kt_id=[]
	unit_members.each do |u|
          if u.tasks_main.include?("Ketua Teras")
	    app+=1
	    kt_id<< u.id
	  elsif u.tasks_main.include?("Ketua Program")
	    app+=1
	  end
	end
	if app==1
	  approver1 = highest_rank.staff_id
	elsif app==2
	  approver1 = Position.find(kt_id[0]).staff_id
	end
      end
      #Academician--end---
      
    elsif ["Teknologi Maklumat", "Perpustakaan", "Kewangan & Akaun", "Sumber Manusia"].include?(applicant_unit) || applicant_unit.include?("logistik") || applicant_unit.include?("perkhidmatan")
      #Administration--start--
      highest_rank = unit_members.sort_by{|x|x.staffgrade.name[-2,2]}.last
      highest_grade = highest_rank.staffgrade.name[-2,2]
      if highest_grade > applicant_grade #staffs
        approver1 = highest_rank.staff_id
      elsif highest_grade == applicant_grade #Ketua Unit
        approver1 =  applicant.position.parent.staff_id
      end
      #Administration--end---
    
    elsif ["Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor"].include?(applicant_unit)
      approver1 = Position.find(:first, :conditions => ['unit=?', "Pentadbiran"]).staff_id

    elsif applicant_unit == "Pengurusan Tertinggi"
      if applicant.position.name=="Pengarah"
        approver1=nil
      else
        approver1=Position.find(:first, :conditions => ['name=?', "Pengarah"]).staff_id
      end
      
    else
      #Administration2--start---
      if applicant.position.parent.staff.id == []
        approver1 = nil
      else
        approver1 = applicant.position.parent.staff.id   #if pentadbiran OK - applicant.position.unit=="Pentadbiran"
      end
      #Administration2--end---
      #-----------------------------------
    end
    #from Travel Request (new format) - end**************************************************************************
    approver1
  end
  
  def total_mileage_request
    #other_claims_total + public_transport_totals
    travel_claim_logs.sum(:mileage)
  end
  
  def total_km_money_request
    #other_claims_total + public_transport_totals
    travel_claim_logs.sum(:km_money)
  end
  
  def transport_class
    abc = TravelClaimsTransportGroup.abcrate
    de = TravelClaimsTransportGroup.derate
    mid = 1820.75
    if applicant.nil? || applicant.blank?
      app2 = Staff.find(:first, :conditions => ['id=?',Login.current_login.staff.id])
      if app2.vehicles && app2.vehicles.count>0
        TravelClaimsTransportGroup.transport_class(app2.vehicles.first.id, app2.current_salary, abc, de, mid)
      else
        'Z'
      end
    else
      if applicant.vehicles && applicant.vehicles.count>0
        TravelClaimsTransportGroup.transport_class(applicant.vehicles.first.id, applicant.current_salary, abc, de, mid)
      else
        'Z'
      end
    end
  end
  
end
