class Programme < ActiveRecord::Base
    # befores, relationships, validations, before logic, validation logic, 
    #controller searches, variables, lists, relationship checking
    before_save :set_combo_code
    after_save :copy_topic_topicdetail
    has_ancestry :cache_depth => true

    has_many :schedule_programmes, :class_name => 'Weeklytimetable', :foreign_key => 'programme_id'
    has_many :schedule_semesters, :class_name => 'Weeklytimetable', :foreign_key => 'semester'
    
    has_many :schedule_details_subjects, :class_name => 'WeeklytimetableDetail', :foreign_key => 'subject'
    has_many :schedule_details_topics,  :class_name => 'WeeklytimetableDetail', :foreign_key => 'topic'

    has_many :topic_details, :class_name => 'Topicdetail', :foreign_key => 'topic_code'   #26March2013
    has_many :lessonplan_topics, :class_name => 'LessonPlan', :foreign_key =>'topic'      #26March2013

    def set_combo_code
      if ancestry_depth == 0
        self.combo_code = code
      else
        self.combo_code = parent.combo_code + "-" + code
      end
    end
    
    def copy_topic_topicdetail
      @topiccode_in_topic_detail = Topicdetail.all.map(&:topic_code)
      if course_type='Topic' && @topiccode_in_topic_detail.include?(id) == false
        @newtopicdetail = Topicdetail.new
        @newtopicdetail.topic_code = id
        @newtopicdetail.duration = Time.now
        @newtopicdetail.theory = Time.now
        @newtopicdetail.tutorial = Time.now
        @newtopicdetail.practical = Time.now
        @newtopicdetail.prepared_by = User.current_user.staff_id
        @newtopicdetail.save
      end  
    end

    def tree_nd
      if is_root?
        gls = ""
      else
        gls = "class=\"child-of-node-#{parent_id}\""
      end
      gls
    end

    def subject_list
        "#{code}" + " " + "#{name}"   
    end

    def programme_list
      if is_root?
        "#{course_type}" + " " + "#{name}"   
      else
      end
    end
    
    def semester_subject_topic
      if ancestry_depth == 3
        "Sem #{parent.parent.code}"+"-"+"#{parent.code}"+" | "+"#{name}"
      elsif ancestry_depth == 4
        ">>Sem #{parent.parent.parent.code}"+"-"+"#{parent.parent.code}"+" | "+"#{code} "+"#{name}"
      end
    end
    
    def semester_subject
      "Sem #{parent.code}"+"-"+"#{code}"+" | "+"#{name}"
    end
    
    def subject_with_topic  #use in lesson plan
      "#{parent.code}"+" - "+"#{name}"
    end
    
    def full_parent
      "#{parent.code}"+" - "+"#{parent.name}"
    end
    
    def programme_coursetype_name
     "#{root.course_type}"+" "+"#{root.name}"
    end
    
    #3June2013-from EXAM model
    def set_year  #SETTING YEAR from Subject.find(1).set_year
      return "1" if (parent.code == "1") || (parent.code == "2")
      return "2" if (parent.code == "3") || (parent.code == "4")
      return "3" if (parent.code == "5") || (parent.code == "6")
    end

    def set_semester
      return  "1" if (parent.code == "1") || (parent.code == "3")||(parent.code == "5") 
      return  "2" if  (parent.code == "2") || (parent.code == "4") || (parent.code == "6")
    end
    #3June2013

    COURSE_STATUS = [
         #  Displayed       stored in db
         [ "Major",     1 ],
         [ "Minor",     2 ],
         [ "Elective",  3 ]
    ]

    DURATION_TYPES = [
         #  Displayed       stored in db
         [ "Hours",      0 ],
         [ "Days",       1 ],
         [ "Weeks",      7 ],
         [ "Months",     30 ],
         [ "Years",      365 ]
    ]

  
end
