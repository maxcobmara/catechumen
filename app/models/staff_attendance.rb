class StaffAttendance < ActiveRecord::Base
  
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  belongs_to :attended, :class_name => 'Staff', :foreign_key => 'thumb_id', :primary_key => 'thumb_id'
  belongs_to :approver, :class_name => 'Staff', :foreign_key => 'approved_by'
  
  validates_presence_of :reason
  
  def self.is_controlled
    find(:all, :order => 'logged_at DESC', :limit => 10000)
  end
  #--shift?
  def self.find_mylate  
    staffshift_id = Staff.find(:first, :conditions => ['thumb_id=?', User.current_user.staff.thumb_id]).staff_shift_id
    if staffshift_id != nil
      start_time = StaffShift.find(staffshift_id).start_at.strftime("%H:%M") 
    else
      start_time = "08:00"
    end
    find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id=? AND logged_at::time > ?", true, "I", User.current_user.staff.thumb_id, start_time ], :order => 'logged_at')
    #asal--below
    #find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id=? AND logged_at::time > ?", true, "I", User.current_user.staff.thumb_id, "08:30" ], :order => 'logged_at')
  end
  def self.find_myearly
    staffshift_id = Staff.find(:first, :conditions => ['thumb_id=?', User.current_user.staff.thumb_id]).staff_shift_id
    if staffshift_id != nil
        end_time = StaffShift.find(staffshift_id).end_at.strftime("%H:%M") 
    else
        end_time = "17:00"
    end
    #TESTING-OK:find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id=? AND logged_at::time < ?", true, "O", 772, "18:00" ], :order => 'logged_at')
    find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id=? AND logged_at::time < ?", true, "O", User.current_user.staff.thumb_id, end_time ], :order => 'logged_at')
    #asal--below
    #find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id=? AND logged_at::time < ?", true, "O", User.current_user.staff.thumb_id, "17:00" ], :order => 'logged_at')
  end
  #--shift?
  def i_have_a_thumb
    if User.current_user.staff.thumb_id == nil
      772
    else
      User.current_user.staff.thumb_id
    end
  end 
  
  def self.find_approvelate
    find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id IN (?)", true, "I", peeps], :order => 'logged_at DESC')
  end
  def self.find_approveearly
    find(:all, :conditions => ["trigger=? AND log_type =? AND thumb_id IN (?)", true,"O", peeps2], :order => 'logged_at DESC')
  end  
  def self.this_month_red
    red_peeps_this_month = StaffAttendance.count(:all, :group => :thumb_id, :conditions => ["trigger = ? AND logged_at BETWEEN ? AND ?", true, Date.today.beginning_of_month, Date.today])
    arr = Array(red_peeps_this_month)
    arr = arr.reject { |a, b| b < 5 }
    arr = arr.sort! { |a, b| b.second <=> a.second }
    arr
  end
  
  def self.last_month_red
    red_peeps_this_month = StaffAttendance.count(:all, :group => :thumb_id, :conditions => ["trigger = ? AND logged_at BETWEEN ? AND ?", true, Date.today.prev_month.beginning_of_month, Date.today.prev_month.end_of_month])
    arr = Array(red_peeps_this_month)
    arr = arr.reject { |a, b| b < 5 }
    arr = arr.sort! { |a, b| b.second <=> a.second }
    arr
  end
  
  def self.previous_month_red
    red_peeps_this_month = StaffAttendance.count(:all, :group => :thumb_id, :conditions => ["trigger = ? AND logged_at BETWEEN ? AND ?", true, Date.today.months_ago(2).beginning_of_month, Date.today.months_ago(2).end_of_month])
    arr = Array(red_peeps_this_month)
    arr = arr.reject { |a, b| b < 5 }
    arr = arr.sort! { |a, b| b.second <=> a.second }
    arr
  end
  
  def self.this_month_green
    red_peeps_this_month = StaffAttendance.count(:all, :group => :thumb_id, :conditions => ["trigger = ? AND logged_at BETWEEN ? AND ?", true, Date.today.beginning_of_month, Date.today])
    arr = Array(red_peeps_this_month)
    arr = arr.reject { |a, b| b < 3 || b > 4 }
    arr = arr.sort! { |a, b| b.second <=> a.second }
    arr
  end
  
  def self.last_month_green
    red_peeps_this_month = StaffAttendance.count(:all, :group => :thumb_id, :conditions => ["trigger = ? AND logged_at BETWEEN ? AND ?", true, Date.today.prev_month.beginning_of_month, Date.today.prev_month.end_of_month])
    arr = Array(red_peeps_this_month)
    arr = arr.reject { |a, b| b < 3 || b > 4 }
    arr = arr.sort! { |a, b| b.second <=> a.second }
    arr
  end
  
  def self.previous_month_green
    red_peeps_this_month = StaffAttendance.count(:all, :group => :thumb_id, :conditions => ["trigger = ? AND logged_at BETWEEN ? AND ?", true, Date.today.months_ago(2).beginning_of_month, Date.today.months_ago(2).end_of_month])
    arr = Array(red_peeps_this_month)
    arr = arr.reject { |a, b| b < 3 || b > 4 }
    arr = arr.sort! { |a, b| b.second <=> a.second }
    arr
  end
  
  
  
  
  #Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", User.current_user.staff.position.child_ids]).map(&:staff_id)
  
  #User.current_user.staff.position.child_ids
  #Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", possibles]).map(&:staff_id)
  
  def self.peeps
    mystaff = User.current_user.staff.position.child_ids
    mystaffids = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", mystaff]).map(&:staff_id)
    thumbs = Staff.find(:all, :select => :thumb_id, :conditions => ["id IN (?)", mystaffids]).map(&:thumb_id)
  end

  def self.peeps2
    mystaff = User.current_user.staff.position.child_ids  #position_ids for mystaff
    #myotherstaff--added-if no superior(act as approver for staff who has no superior)
    #myotherstaff = StaffAttendance.find(:all,:select=>:thumb_id,:conditions=>['approved_by=?',User.current_user.staff_id]).map(&:thumb_id) #position_ids for myotherstaff
    #mystaffids = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", mystaff+myotherstaff]).map(&:staff_id)
    mystaffids = Position.find(:all, :select => "staff_id", :conditions => ["id IN (?)", mystaff]).map(&:staff_id)
    thumbs = Staff.find(:all, :select => :thumb_id, :conditions => ["id IN (?)", mystaffids]).map(&:thumb_id)
  end
    
  def attendee_details 
      if attended.blank?
        thumb_id.to_s + " - " +"Thumb ID not reged"
      elsif thumb_id?
        attended.name
      else 
      end
  end
  
  def group_by_thingy
    logged_at.to_date.to_s
  end
  
  def r_u_late
    mins = logged_at.min.to_s
		#---
		#shift = Staff.find(:first, :conditions => ['thumb_id=?',thumb_id]).staff_shift_id 
		#if shift != nil
		  #shift_start = StaffShift.find(shift).start_at
		  #starting_time = (shift_start.strftime('%H').to_i * 100) + shift_start.strftime('%M').to_i
		#else
		  #starting_time = 830
		#end
		#---
    if mins.size == 1
      mins = "0" + mins
    end
    timmy = ((logged_at.hour - 8).to_s + mins).to_i
    if timmy > starting_shift && self.trigger != false    #if timmy > starting_time && self.trigger != false  #if timmy > 830 && self.trigger != false
      "flag"
    else 
    end
  end
  
  def r_u_early
      mins = logged_at.min.to_s
      if mins.size == 1
         mins = "0" + mins
      end
      if log_type == 'O'
          timmy = (logged_at.in_time_zone('UTC').strftime('%H%M')).to_i   #giving this format 1800 @ #0840 -> 840 --> if 00:02 will become 2
          if timmy < ending_shift && self.trigger != false && timmy2 < 0  #(&& timmy2 < 0)to work with logout at time after 12:00 midnight --> 00:00hrs
              "flag"
          else 
              if ending_shift == 700 #yg tak de shift
                  if timmy < 1700
                      "flag"
                  end
              end
          end
      end   #end for if log_type == 'O'
  end

  
  def timmy2
    mins = logged_at.min.to_s
    if mins.size == 1
      mins = "0" + mins
    end
    timmy = ((logged_at.hour - 8).to_s + mins).to_i
  end
  
  #--added use for r_u_late & late_early
  def starting_shift
    shift = Staff.find(:first, :conditions => ['thumb_id=?',thumb_id]).staff_shift_id 
		if shift != nil
		  shift_start = StaffShift.find(shift).start_at
		  (shift_start.strftime('%H').to_i * 100) + shift_start.strftime('%M').to_i
		else
		  800 #830 -> (800 -- 8.00 am) 
		end
  end
  
  def ending_shift        #return this format -> 1800
    shift = Staff.find(:first, :conditions => ['thumb_id=?',thumb_id]).staff_shift_id 
		if shift != nil
		  shift_end = StaffShift.find(shift).end_at
		  #(shift_end.strftime('%H').to_i * 100) + shift_end.strftime('%M').to_i  #(shift_end.strftime('%H').to_i)* 100 + shift_end.strftime('%M').to_i
		  (shift_end.strftime('%H%M').to_i)
		else
		  700 #730 -> (700 -- 5.00 pm)  ##TEMPORARY SOLUTION - FAILED TO SEND VALUE as 1700 -> refer line 214-221
		end
  end
  #--added use for r_u_late & late_early
  
  def late_early
    mins = logged_at.min.to_s
    #----------------------start---------for logged-in
    if log_type=='I'  
        #----  #replace (timmy = timmy2 ) 161-166 
        #if mins.size == 1
            #mins = "0" + mins
        #end
        #timmy = ((logged_at.hour - 8).to_s + mins).to_i 
        #----
        shift = Staff.find(:first, :conditions => ['thumb_id=?',thumb_id]).staff_shift_id 
    		minit_shift = (StaffShift.find(shift).start_at.min) if shift != nil
        
        
        if timmy2 > starting_shift && self.trigger != false     #if 822 > 730 && self.trigger != false
            diff = timmy2-starting_shift #(822-730)
            if minit_shift!=nil && mins.to_i < minit_shift                          #if 22 < 30
                minit_diff = ((mins.to_i+60)-minit_shift)
                #late = ((diff/100)-1).to_s+" hours " 
                #$$$$$$-----------------------------
                if diff > 99 && minit_diff <= 0 
                    late = (diff/100).to_s+" hours "
                elsif diff > 99 && minit_diff > 0 
                    late = (diff/100).to_s+" hours "+"#{minit_diff} minutes"
                elsif minit_diff > 0 && diff < 100
                    late ="#{minit_diff} minutes"
                end
                
                #$$$$$$-----------------------------
            else
                if diff > 99 
                    late = (diff/100).to_s+" hours " + (diff % 100).to_s+" minutes"       #in hours & minutes
                    #late = (((diff/100)* 60) + (diff % 100)).to_s + " minutes"           #in minutes only       
                else
                    late = "#{diff} minutes"
                end
            end
            #######
            "<font color=red>"+late+"</font>"
            ######
        else
            "-"#  "punctual-masuk" 
        end
    #----------------------end---------for logged-in
    elsif log_type == 'O' 
    #----------------------start------for logged-out
      shift = Staff.find(:first, :conditions => ['thumb_id=?',thumb_id]).staff_shift_id 
  		if shift != nil
  		    shift_end = StaffShift.find(shift).end_at
  		    #==================
  		    minit_shift = (StaffShift.find(shift).end_at.min)
    		  if minit_shift == 0  
    			    jam = ( (StaffShift.find(shift).end_at.strftime('%H').to_i) - 8)-1
    			    minit = 60
    		  else
    		      jam = (StaffShift.find(shift).end_at.strftime('%H').to_i) - 8
    		      minit = minit_shift
    		  end
  		    #==================
  		else
  		    #1700 --> 8j60m (if shift end at 5pm)
  		    #1800 --> 9j60m (if shift end at 6pm)
  		    jam = 8 #9
  		    minit = 60 
  		end
      #--------
      if mins.size == 1
        mins = "0" + mins
      end
      ##*****
      timmy_jam = ((logged_at.in_time_zone('UTC').strftime('%H')).to_i)-8 #logged_at.hour.to_s
      timmy_minutes = mins.to_i
      ##*****
      timmy = (logged_at.in_time_zone('UTC').strftime('%H%M')).to_i   #giving this format 1800 @ #0840 -> 840
      if timmy < ending_shift && self.trigger != false && timmy2 < 0  #(&& timmy2 < 0)to work with logout at time after 12:00 midnight --> 00:00hrs
          #DO NOT REMOVE YET-below-working one!
          #early = "#{ending_shift} ~ #{timmy}" + " minutes" + "<BR>JAM_SHIFT:#{jam} MINIT_SHIFT:#{minit_shift} MINIT:#{minit}"+"<BR>TIMMYJAM:#{timmy_jam} TIMMYMINUTES:#{timmy_minutes}"
          jam_diff = (jam - timmy_jam)
          minit_diff = (minit - timmy_minutes)
          #early = (jam_diff.to_s+" hours " if jam_diff>0) + (minit_diff.to_s+" minutes" if minit_diff>0) # +"#{timmy} ~ #{ending_shift} "
          #replace above early with these line : (page 15:http://localhost:3000/staff_attendances?id=2012-10-02)
          #$$$$$$-----------------------------
          if jam_diff > 0 && minit_diff <= 0 
              early = "#{jam_diff} hours"
          elsif jam_diff > 0 && minit_diff > 0 
              early = "#{jam_diff} hours #{minit_diff} minutes"
          elsif minit_diff > 0 && jam_diff <= 0
              early ="#{minit_diff} minutes"
          end
          "<font color=red>"+early+"</font>"
          #$$$$$$-----------------------------
      else
          #TEMPORARY SOLUTION ------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          if ending_shift == 700 #for cases - without staff_shift
            if timmy < 1700   #use accordingly : (if timmy < 1800) 1700 for shift end at 5pm & 1800 for shift end at 6pm
              jam_diff = (jam - timmy_jam)
              minit_diff = (minit - timmy_minutes)
              if jam_diff > 0 && minit_diff <= 0 
                  early = "#{jam_diff} hours"
              elsif jam_diff > 0 && minit_diff > 0 
                  early = "#{jam_diff} hours #{minit_diff} minutes"
              elsif minit_diff > 0 && jam_diff <= 0
                  early ="#{minit_diff} minutes"
              end
              "<font color=red>"+early+"</font>"
            else 
              "-"#  "puntual-balik (without staff_shift)" 
            end
             
          else  #for cases - with staff_shift
            "-" #  "punctual-balik (with staff_shift)"
          end
          #TEMPORARY SOLUTION ------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      end
    #----------------------start------for logged-out
    end
    
  end
  
 
  
end
