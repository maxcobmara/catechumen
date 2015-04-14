class Personalizetimetablesearch < ActiveRecord::Base
  attr_accessible :lecturer, :startdate, :enddate, :programme_id #use programme_id for valid wt (intake match w programme)
  attr_accessor :method
  
  def personalizetimetables
     @personalizetimetables ||= find_personalizetimetables
   end

   private

   def find_personalizetimetables
     WeeklytimetableDetail.find(:all, :conditions => conditions,  :order => orders)   
   end
   
   def programme_id_conditions
     valid_wt_ids = Weeklytimetable.valid_wt_ids
     if valid_wt_ids.count > 0
       a=" weeklytimetable_id=? " if valid_wt_ids.count > 0
       0.upto(valid_wt_ids.count-2).each do |cnt|
         a+=" OR weeklytimetable_id=? "
       end
       ["("+a+")", valid_wt_ids] if programme_id == 1
     end
   end

   def lecturer_conditions
     ["lecturer_id=?", lecturer] unless lecturer.blank?      
   end
  
   def startdate_conditions
     unless startdate.blank? 
       searched_slots=[]
       WeeklytimetableDetail.all.sort_by{|y|y.weeklytimetable.startdate}.each do |m|
         searched_slots << m if m.get_date_schedule >= startdate 
       end
       a="id=? " if searched_slots.count > 0
       0.upto(searched_slots.count-2) do |cnt|
         a+=" OR id=? "
       end
     end
     ["("+a+")", searched_slots.map(&:id).uniq] unless startdate.blank?   #become AND
   end
   
   def enddate_conditions
     unless enddate.blank? 
       enddate2=enddate.end_of_month
       searched_slots=[]
       WeeklytimetableDetail.all.sort_by{|y|y.weeklytimetable.startdate}.each do |m|
         searched_slots << m if m.get_date_schedule <= enddate2
       end
       a="id=? " if searched_slots.count > 0
       0.upto(searched_slots.count-2) do |cnt|
         a+=" OR id=? "
       end
     end
     ["("+a+")", searched_slots.map(&:id).uniq] unless enddate.blank?   #become AND
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
