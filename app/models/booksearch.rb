class Booksearch < ActiveRecord::Base
  attr_accessible :title, :author, :isbn, :accessionno, :classno, :stock_summary, :accessionno_start, :accessionno_end, :accumbookloan
  attr_accessor :method
  
  def sbooks
    @sbooks ||= find_sbooks
  end
  
  private

  def find_sbooks
    Book.find(:all, :conditions => conditions,  :order => orders)   
  end

  def title_conditions
    ["title ILIKE ?","%#{title}%" ] unless title.blank?
  end
  
  def author_conditions
    ["author ILIKE ?", "%#{author}%" ] unless author.blank?      
  end
  
  def isbn_conditions
    ["isbn LIKE ?", "%#{isbn}%" ] unless isbn.blank?      
  end
  
  def accessionno_conditions
    ["accessionno ILIKE ?", "%#{accessionno}%" ] unless accessionno.blank?      
  end
  
  def classno_conditions
    #["classlcc LIKE ?", "%#{classno}%"] if classno.blank? == false && stock_summary == 1
    ["classlcc ILIKE ?", "%#{classno}%"] if (classno.blank? == false && stock_summary == 1)||(classno.blank? == false && stock_summary == 2)
  end 
  
  def accessionno_start_conditions
    ['accessionno>=?', accessionno_start] if (accessionno_start.blank? == false && stock_summary == 1)||(accessionno_start.blank? == false && stock_summary == 2)
  end
  
  def accessionno_end_conditions
    ['accessionno<=?', accessionno_end] if (accessionno_end.blank? == false && stock_summary == 1)||(accessionno_end.blank? == false && stock_summary == 2)
  end
  
  #def accumbookloan_details
    #a='accessionno=? ' if Accession.find(:all,:conditions=>['id IN (?)',Librarytransaction.find(:all, :conditions=>['checkoutdate >=? AND checkoutdate <=?', '2013-01-01','2013-12-31']).map(&:accession_id)]).map(&:accession_no).count!=0
   ## a='accessionno=? ' if Accession.find(:all,:conditions=>['id IN (?)',Librarytransaction.find(:all, :conditions=>['checkoutdate >=? AND checkoutdate <=?', '2013-01-01','2013-12-31']).map(&:accession_id)]).map(&:accession_no).uniq.count!=0
    #0.upto(Accession.find(:all,:conditions=>['id IN (?)',Librarytransaction.find(:all, :conditions=>['checkoutdate >=? AND checkoutdate <=?', '2013-01-01','2013-12-31']).map(&:accession_id)]).map(&:accession_no).count-2) do |l|  
    ##0.upto(Accession.find(:all,:conditions=>['id IN (?)',Librarytransaction.find(:all, :conditions=>['checkoutdate >=? AND checkoutdate <=?', '2013-01-01','2013-12-31']).map(&:accession_id)]).map(&:accession_no).uniq.count-1) do |l|  
      #a=a+'OR accessionno=? '
    #end 
    #return a if accumbookloan==1
  #end
  
  #def accumbookloan_conditions
    #[accumbookloan_details, Accession.find(:all,:conditions=>['id IN (?)',Librarytransaction.find(:all, :conditions=>['checkoutdate >=? AND checkoutdate <=?', '2013-01-01','2013-12-31']).map(&:accession_id)]).map(&:accession_no)]
  #end
  
  def orders
     "accessionno ASC"
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
