class Counselling < ActiveRecord::Base
  belongs_to :student
  belongs_to :cofile
 
   def self.find_main
     Student.find(:all, :condition => ['student_id IS NULL'])
   end
   
   # code for repeating field session
   has_many :scsessions, :dependent => :destroy

   def new_scsession_attributes=(scsession_attributes)
     scsession_attributes.each do |attributes|
       scsessions.build(attributes)
     end
   end

   after_update :save_scsessions

   def existing_scsession_attributes=(scsession_attributes)
     scsessions.reject(&:new_record?).each do |scsession|
       attributes = scsession_attributes[scsession.id.to_s]
       if attributes
         scsession.attributes = attributes
       else
         scsessions.delete(scsession)
       end
     end
   end

   def save_scsessions
     scsessions.each do |scsession|
       scsession.save(false)
     end
   end
end
