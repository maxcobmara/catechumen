class Personalizetimetablesearch < ActiveRecord::Base
  attr_accessible :lecturer, :programme_id
  attr_accessor :method
  
  def personalizetimetables
     @personalizetimetables ||= find_personalizetimetables
   end

   private

   def find_personalizetimetables
     WeeklytimetableDetail.find(:all, :conditions => conditions,  :order => orders)   
   end

   def lecturer_conditions
     ["lecturer_id=?", lecturer] unless lecturer.blank?      
   end
  
   
   def orders
     "id ASC"
   end  

   def conditions
     [conditions_clauses.join(' AND '), *conditions_options] #works like OR?????
   end

   def conditions_clauses
     conditions_parts.map { |condition| condition.first }
   end

   def conditions_options
     conditions_parts.map { |condition| condition[1..-1] }.flatten
   end

   def conditions_parts
     private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
   end
end
