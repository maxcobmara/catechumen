class Klass < ActiveRecord::Base

has_many :klasstime, :class_name => 'Timetable', :foreign_key => 'classroom_id'
has_many :class_plan, :class_name => 'Topic', :foreign_key => 'class_id'
has_many :classroom, :class_name => 'AnalysisGrades', :foreign_key => 'class_id'
belongs_to :subjectclass,    :class_name => 'Subject', :foreign_key => 'subject_id'
belongs_to :programclass,    :class_name => 'Programme', :foreign_key => 'programme_id'

has_many :klass,    :class_name => 'analysispaperexam', :foreign_key => 'class_id'
has_many :studentattendances
#Link to HABTM klass_student
#links to Model analysispaperexam
has_and_belongs_to_many :students

 attr_accessible :name, :programme_id, :subject_id
  attr_accessible :student_ids


  def programme_for_class
    if programclass.blank?
      "-"
    else
      programclass.programme_with_specialisation
    end
  end
  

   def bil
       v=1
    end
    
def subject_klass
  suid = subject_id.to_a
  exists = Subject.find(:all, :select => "id").map(&:id)
  checker = suid & exists

  if subject_id == nil
      ""
  elsif checker == []
    "-"
  else
        subjectclass.subject_code_with_subject_name
  end
end
end
