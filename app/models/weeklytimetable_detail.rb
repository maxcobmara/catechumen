class WeeklytimetableDetail < ActiveRecord::Base
   
   before_save :set_day_time_slot_for_non_selected
   before_destroy :check_student_attendance, :check_lesson_plan
   
   belongs_to :weeklytimetable,     :foreign_key => 'weeklytimetable_id'
   belongs_to :weeklytimetable_subject,   :class_name => 'Programme',   :foreign_key => 'subject' #starting 25March2013-no longer use
   belongs_to :weeklytimetable_topic,     :class_name => 'Programme',   :foreign_key => 'topic'
   belongs_to :weeklytimetable_lecturer,  :class_name => 'Staff',       :foreign_key => 'lecturer_id'
   belongs_to :weeklytimetable_location,  :class_name => 'Location',    :foreign_key => 'location'
   has_one     :lessonplan, :class_name => 'LessonPlan',  :foreign_key => 'schedule', :dependent => :nullify #once removed, require re-selection of schedule in lesson_plan
   has_many   :student_attendances
   
   #validates_uniqueness_of :lecturer_id, :time_slot, :time_slot2, :day2, :is_friday, :scope => :weeklytimetable_id
   validates_presence_of :lecturer_id, :topic#,:time_slot, :time_slot2, :day2, :is_friday, :location
   
   def set_day_time_slot_for_non_selected
       if is_friday == true
         self.day2 = 0
         self.time_slot2 = 0
       elsif is_friday != true 
         self.is_friday = false
         self.time_slot = 0
       end 
   end
   
   def get_date_schedule
     sdate = Weeklytimetable.find(weeklytimetable_id).startdate
     endate = Weeklytimetable.find(weeklytimetable_id).enddate
     return sdate if day2 == 1
     return sdate+1 if day2 == 2
     return sdate+2 if day2 == 3
     return sdate+3 if day2 == 4
     return sdate+4 if is_friday == true
     return sdate+5 if day2 == 6
     return sdate+6 if day2 == 7
   end
   
   def get_date_for_lesson_plan
     sdate = Weeklytimetable.find(weeklytimetable_id).startdate
     endate = Weeklytimetable.find(weeklytimetable_id).enddate
     return I18n.l((sdate), :format => '%d-%b-%Y')  if day2 == 1
     return I18n.l((sdate+1), :format => '%d-%b-%Y')  if day2 == 2
     return I18n.l((sdate+2), :format => '%d-%b-%Y')  if day2 == 3
     return I18n.l((sdate+3), :format => '%d-%b-%Y')  if day2 == 4
     return I18n.l((sdate+4), :format => '%d-%b-%Y')  if is_friday == true
      return I18n.l((sdate+5), :format => '%d-%b-%Y')  if day2 == 6
      return I18n.l((sdate+6), :format => '%d-%b-%Y')  if day2 == 7
   end   
   
   def get_date_day_of_schedule
      sdate = Weeklytimetable.find(weeklytimetable_id).startdate
      endate = Weeklytimetable.find(weeklytimetable_id).enddate
      #return (sdate).strftime('%d-%b-%Y') + " Mon" if day2 == 1  t('date.abbr_day_names')
      return I18n.l((sdate), :format => '%d-%b-%Y') + " "+ I18n.t(:'date.abbr_day_names')[0] if day2 == 1
      return I18n.l((sdate+1), :format => '%d-%b-%Y') +" "+ I18n.t(:'date.abbr_day_names')[1] if day2 == 2
      return I18n.l((sdate+2), :format => '%d-%b-%Y') +" "+ I18n.t(:'date.abbr_day_names')[2] if day2 == 3
      return I18n.l((sdate+3), :format => '%d-%b-%Y') +" "+ I18n.t(:'date.abbr_day_names')[3] if day2 == 4
      return I18n.l((sdate+4), :format => '%d-%b-%Y') +" "+ I18n.t(:'date.abbr_day_names')[4] if is_friday == true  
      return I18n.l((sdate+5), :format => '%d-%b-%Y') +" "+ I18n.t(:'date.abbr_day_names')[5] if day2 == 6
      return I18n.l((sdate+6), :format => '%d-%b-%Y') +" "+ I18n.t(:'date.abbr_day_names')[6] if day2 == 7
   end   
   
   def get_day_of_schedule
      sdate = Weeklytimetable.find(weeklytimetable_id).startdate
      endate = Weeklytimetable.find(weeklytimetable_id).enddate
      return I18n.t(:'date.abbr_day_names')[0] if day2 == 1
      return I18n.t(:'date.abbr_day_names')[1] if day2 == 2
      return I18n.t(:'date.abbr_day_names')[2] if day2 == 3
      return I18n.t(:'date.abbr_day_names')[3] if day2 == 4
      return I18n.t(:'date.abbr_day_names')[4] if is_friday == true  
      return I18n.t(:'date.abbr_day_names')[5] if day2 == 6
      return I18n.t(:'date.abbr_day_names')[6] if day2 == 7
   end
   
   def tperiod_val
     timeslot = time_slot2 if is_friday == false || is_friday == nil
     timeslot = time_slot if is_friday == true 
     itsformat = Weeklytimetable.find(weeklytimetable_id).format1 if is_friday == false || is_friday == nil
     itsformat = Weeklytimetable.find(weeklytimetable_id).format2 if is_friday == true
     #"#{TimetablePeriod.find(:first, :conditions=>['timetable_id=? and sequence=?', itsformat, timeslot]).try(:start_at).try(:strftime,"%H:%M %p")}"
     return TimetablePeriod.find(:first, :conditions=>['timetable_id=? and sequence=?', itsformat, timeslot])
   end
   
   def get_start_end_time
     tperiod = tperiod_val
     unless tperiod.nil?
       "#{I18n.l(tperiod.start_at, :format => '%H:%M')} - #{I18n.l(tperiod.end_at, :format => '%H:%M %P')}"
     else
     "#{TimetablePeriod.find(:first, :conditions=>['timetable_id=? and sequence=?', itsformat, timeslot]).try(:start_at).try(:strftime,"%H:%M")} - #{TimetablePeriod.find(:first, :conditions=>['timetable_id=? and sequence=?', itsformat, timeslot]).try(:end_at).try(:strftime,"%H:%M %P")}"
     end
   end
   
   def get_start_time
     tperiod = tperiod_val
     unless tperiod.nil?
       "#{I18n.l(tperiod.start_at, :format => '%H:%M %P')}"
     else
     "#{TimetablePeriod.find(:first, :conditions=>['timetable_id=? and sequence=?', itsformat, timeslot]).try(:start_at).try(:strftime,"%H:%M %P")}"
     end
   end   
   
   def get_end_time
    tperiod = tperiod_val
     unless tperiod.nil?
       "#{I18n.l(tperiod.end_at, :format => '%H:%M %P')}"
     else
     "#{TimetablePeriod.find(:first, :conditions=>['timetable_id=? and sequence=?', itsformat, timeslot]).try(:end_at).try(:strftime,"%H:%M %P")}"
     end
   end   
   
   def get_time_slot
      timeslot = time_slot2 if is_friday == false || is_friday == nil
      timeslot = time_slot if is_friday == true 
      itsformat = Weeklytimetable.find(weeklytimetable_id).format1 if is_friday == false || is_friday == nil
      itsformat = Weeklytimetable.find(weeklytimetable_id).format2 if is_friday == true
      stime = get_start_time+"-"+get_end_time
   end
   
   def day_time_slot
      "#{get_date_day_of_schedule}"+" | "+"#{get_time_slot}"+" | "+"#{Programme.find(topic).subject_with_topic}"
   end
   
   def day_time_slot2
      "#{get_date_day_of_schedule}"+" | "+"#{get_time_slot}"
   end
   
   def day_time_slot3
     "#{weeklytimetable_lecturer.name[0,10]}"+" | "+"#{day_time_slot}"
   end
   
   def subject_day_time
     ancestry_topic=Programme.find(topic).ancestry_depth
     if ancestry_topic==3
       "#{Programme.find(topic).parent.code}"+" | "+"#{get_date_day_of_schedule}"+" | "+"#{get_time_slot}"
     elsif ancestry_topic==4
       "#{Programme.find(topic).parent.parent.code}"+" | "+"#{get_date_day_of_schedule}"+" | "+"#{get_time_slot}"
     end
   end
   
   def subject_topic
     #{}"#{Programme.find(topic).subject_with_topic}"
     "#{Programme.find(topic).parent.code}"+" : "+"#{Programme.find(topic).subject_list}"
   end
   
   def render_class_method
     (WeeklytimetableDetail::CLASS_METHOD.find_all{|disp, value| value == lecture_method}).map {|disp, value| disp}
   end
   
   def subject_day_time_class_method
      "#{subject_day_time}"+ " ("+"#{render_class_method}"+")"
   end
   
   #for use in Equery - Lesson Plan
   def self.valid_sch_ids
     valid_wt_ids = Weeklytimetable.valid_wt_ids
     #below - topic in LessonPlan & topic in WeeklytimetableDetail must match
     valid_topics=[]
     LessonPlan.all.each do |lp|
       wtd_topic=WeeklytimetableDetail.find(lp.schedule).topic if WeeklytimetableDetail.all.map(&:id).include?(lp.schedule)
       valid_topics << lp.topic if wtd_topic==lp.topic
     end
     WeeklytimetableDetail.find(:all, :conditions => ['weeklytimetable_id IN(?) and topic IN(?)', valid_wt_ids, valid_topics]).map(&:id)
   end

   DAY_LIST = [
           #  Displayed       stored in db
           [I18n.t(:'date.day_names')[0],     1],
           [I18n.t(:'date.day_names')[1],    2],
           [I18n.t(:'date.day_names')[2],  3],
           [I18n.t(:'date.day_names')[3],   4]
     ]
    DAY_LIST2 = [
           #  Displayed       stored in db
           [I18n.t(:'date.day_names')[0],     1],
           [I18n.t(:'date.day_names')[1],    2],
           [I18n.t(:'date.day_names')[2],  3],
           [I18n.t(:'date.day_names')[3],   4],
           [I18n.t(:'date.day_names')[4], 6],
           [I18n.t(:'date.day_names')[5], 7]
     ]
    CLASS_METHOD = [
           #  Displayed       stored in db
           [I18n.t('weeklytimetable_detail.lecture.'), 1],
           [I18n.t('weeklytimetable_detail.tutorial'), 2],
           [I18n.t('weeklytimetable_detail.practical'), 3]
     ]
     
     #24March2013==========
     IntakeOption = Struct.new(:id, :name)
     class IntakeGroup
       attr_reader :type_name, :options
       def initialize(name)
         @type_name = name
         @options = []
       end
       def <<(option)
         @options << option
       end
     end  

       @grouped=[]
       Programme.at_depth(3).group_by{|t|t.ancestry}.each do |x, items|
         #####
            #@group = IntakeGroup.new("#{Programme.find_by_ancestry(x).parent.name}")
            @group = IntakeGroup.new("#{Programme.find_by_ancestry(x).parent.parent.course_type}"+" "+"#{Programme.find_by_ancestry(x).parent.parent.name}"+"-"+"#{Programme.find_by_ancestry(x).parent.subject_list}")
            items.each do |z|
              if z.parent.parent.parent_id == 3
                @group << IntakeOption.new("#{z.id}","#{z.name}")     #+"#{z.parent.name}"
              end
            end
            @grouped << @group
         #####
       end

       intake_count = Programme.at_depth(3).group_by{|t|t.ancestry}.count 
       
       1.upto(intake_count) do |y|
       end


       OPTIONS=[@grouped[0]] if intake_count == 1
       OPTIONS=[@grouped[0], @grouped[1]] if intake_count == 2
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2]] if intake_count == 3
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3] ] if intake_count == 4
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4]] if intake_count == 5
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5]] if intake_count == 6
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6]] if intake_count == 7
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7]] if intake_count == 8
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8]] if intake_count == 9
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8], @grouped[9]] if intake_count == 10
       
       OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8], @grouped[9],@grouped[10], @grouped[11], @grouped[12], @grouped[13], @grouped[14], @grouped[15], @grouped[16], @grouped[17], @grouped[18], @grouped[19],@grouped[20], @grouped[21], @grouped[22], @grouped[23], @grouped[24], @grouped[25], @grouped[26], @grouped[27], @grouped[28], @grouped[29],@grouped[30], @grouped[31], @grouped[32], @grouped[33], @grouped[34], @grouped[35], @grouped[36], @grouped[37], @grouped[38], @grouped[39],@grouped[40], @grouped[41], @grouped[42], @grouped[43], @grouped[44], @grouped[45]] if intake_count == 46
       
  def self.subject_topic(programme_id)
    #return Programme.find(:all, :conditions => ["id=?",programme_id])
       @grouped=[]
       #25March2013
       Programme.at_depth(3).group_by{|t|t.ancestry}.each do |x, items|
         #####
            #@group = IntakeGroup.new("#{Programme.find_by_ancestry(x).parent.name}")
            @group = IntakeGroup.new("#{Programme.find_by_ancestry(x).parent.parent.course_type}"+" "+"#{Programme.find_by_ancestry(x).parent.parent.name}"+"-"+"#{Programme.find_by_ancestry(x).parent.subject_list}")
            items.each do |z|
              if z.parent.parent.parent_id == 3
                @group << IntakeOption.new("#{z.id}","#{z.name}")     #+"#{z.parent.name}"
              end
            end
            @grouped << @group
         #####
       end

       intake_count = Programme.at_depth(3).group_by{|t|t.ancestry}.count 
       
       1.upto(intake_count) do |y|
       end


       #OPTIONS=[@grouped[0]] if intake_count == 1
       #OPTIONS=[@grouped[0], @grouped[1]] if intake_count == 2
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2]] if intake_count == 3
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3] ] if intake_count == 4
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4]] if intake_count == 5
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5]] if intake_count == 6
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6]] if intake_count == 7
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7]] if intake_count == 8
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8]] if intake_count == 9
       #OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8], @grouped[9]] if intake_count == 10
       
       opt=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8], @grouped[9],@grouped[10], @grouped[11], @grouped[12], @grouped[13], @grouped[14], @grouped[15], @grouped[16], @grouped[17], @grouped[18], @grouped[19],@grouped[20], @grouped[21], @grouped[22], @grouped[23], @grouped[24], @grouped[25], @grouped[26], @grouped[27], @grouped[28], @grouped[29],@grouped[30], @grouped[31], @grouped[32], @grouped[33], @grouped[34], @grouped[35], @grouped[36], @grouped[37], @grouped[38], @grouped[39],@grouped[40], @grouped[41], @grouped[42], @grouped[43], @grouped[44], @grouped[45]] if intake_count == 46
    return opt

  end
     #25March2013==========
     private
     
     def check_student_attendance
       student_attendance_exist = StudentAttendance.find(:all, :conditions=>['weeklytimetable_details_id=?',id])
       if student_attendance_exist.count>0
         return false
       end
     end
     
     #this part will only restrict user from REMOVING current daily timetable detail (TIME SLOT)
     #but pls note replacing content(topic, location etc) of current daily timetable detail (TIME SLOT) shall REFLECT schedule details(topic, timing, etc) in Lesson Plan
     def check_lesson_plan
       current_schedule = 
       submitted_lesson_plan = LessonPlan.find(:all, :conditions => ['is_submitted=?', true]).map(&:schedule)
       if submitted_lesson_plan.include?(self.id)
         #lesson plan created, schedule editable? #issue arise during training : lesson plan first created by lecturer, schedule used to be last minute produce by Coordinator
         #errors.add_to_base "tak bole la"
         # raise I18n.t("weeklytimetable_detail.removal_not_allowed")
         return false
       end
     end
     
end
