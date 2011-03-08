class Page < ActiveRecord::Base
   has_many :subpages, :class_name => 'Page', :foreign_key => 'parent_id'
   belongs_to :parent, :class_name => 'Page', :foreign_key => 'parent_id'
   
   
  def page_description
     "#{position}  (#{navlabel})"
  end
   
   def self.find_main
       Page.find(:all, :conditions => ['parent_id IS NULL'], :order => 'position')
   end

     def self.find_main_public
       Page.find(:all, :conditions => ['parent_id IS NULL and admin != ?', true], :order => 'position')
     end
     
     def self.search(search)
        if search
         @page = Page.find(:all, :conditions => ["navlabel ILIKE ?","%#{search}%"])
        else
         @page = Page.find(:all)
        end
     end
  
end
