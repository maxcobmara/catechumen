class Librarytransactionsearch < ActiveRecord::Base
  attr_accessible :accumbookloan , :programme, :fines, :bookloans, :yearstat, :details
  attr_accessor :method
  
  def librarytransactions
    @librarytransactions ||= find_librarytransactions
  end
  
  private

  def find_librarytransactions
    Librarytransaction.find(:all, :conditions => conditions,  :order => orders)   
  end
  
  def yearstat_conditions
    #["checkoutdate>=? AND checkoutdate<=?","2013-01-01", "2013-12-31" ] unless yearstat.blank?    #if accumbookloan==1 
    ["checkoutdate>=? AND checkoutdate<=?",yearstat.beginning_of_year, yearstat.end_of_year ] unless yearstat.blank? 
  end
  
  def accumbookloan_conditions
    ["accession_id IS NOT NULL"] if accumbookloan == 1
  end
  
  def programme_conditions
    ["staff_id IS NOT NULL AND student_id IS NOT NULL"] if programme == 1
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
