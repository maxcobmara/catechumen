class Curriculum < ActiveRecord::Base
  has_and_belongs_to_many :assets
  belongs_to :staff, :foreign_key => 'staff_id'
  has_many :examquestion, :foreign_key => 'curriculum_id'
  
  CATEGORY = [
        #  Displayed       stored in db
        [ "Course","1" ],
        [ "Subject","2" ],
        [ "Topik", "3" ]
   ]
   
   # code for repeating field doc
   has_many :docs, :dependent => :destroy

   def new_doc_attributes=(doc_attributes)
     doc_attributes.each do |attributes|
       docs.build(attributes)
     end
   end

   after_update :save_docs

   def existing_doc_attributes=(doc_attributes)
     docs.reject(&:new_record?).each do |doc|
       attributes = doc_attributes[doc.id.to_s]
       if attributes
         doc.attributes = attributes
       else
         docs.delete(doc)
       end
     end
   end

   def save_docs
     docs.each do |doc|
       doc.save(false)
     end
   end
   
   
   def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
end
