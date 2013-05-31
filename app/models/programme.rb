class Programme < ActiveRecord::Base
    # befores, relationships, validations, before logic, validation logic, 
    #controller searches, variables, lists, relationship checking
    before_save :set_combo_code
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
      "Sem #{parent.parent.code}"+"-"+"#{parent.code}"+" | "+"#{name}"
    end
    
    def subject_with_topic  #use in lesson plan
      "#{parent.code}"+" - "+"#{name}"
    end
    
    def full_parent
      "#{parent.code}"+" - "+"#{parent.name}"
    end

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
