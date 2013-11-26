class Documentsearch < ActiveRecord::Base
  attr_accessible :refno, :category, :title, :letterdt, :letterxdt, :from, :file_id, :closed, :sender,:letterdtend, :letterxdtend
  attr_accessor :method
  
  def documents
    @documents ||= find_documents
  end
  
  private

  def find_documents
    Document.find(:all, :conditions => conditions,  :order => orders)   
  end

  def refno_conditions
    ["refno=?", refno] unless refno.blank?      
  end

  def category_conditions
    ["category=?", category] unless category.blank?
  end
  
  def title_conditions
    ["title ILIKE ?","%#{title}%" ] unless title.blank?
  end
  
  def letterdt_conditions
    #["letterdt=?", letterdt] unless letterdt.blank?
    #["letterdt>=? AND letterdt<?", letterdt, letterdt+1.day] unless letterdt.blank?
    ["letterdt>=?" , letterdt] unless letterdt.blank?
  end
  
  def letterdtend_conditions
    #["letterdt=?", letterdt] unless letterdt.blank?
    ["letterdt<?", letterdtend+1.day] unless letterdtend.blank?
  end
  
  def letterxdt_conditions
    #["letterxdt=?", letterxdt] unless letterxdt.blank?
    ["letterxdt>=? AND letterxdt<?", letterxdt, letterxdt+1.day] unless letterxdt.blank?
  end
  
  def sender_conditions
     ["sender ILIKE ?","%#{sender}%" ] unless sender.blank? 
  end
  
  def file_id_details
      a='id=? ' if Document.find(:all,:conditions=>['file_id=?',file_id]).map(&:id).uniq.count!=0
      0.upto(Document.find(:all,:conditions=>['file_id=?',file_id]).map(&:id).uniq.count-2) do |l|  
        a=a+'OR id=? '
      end 
      return a unless file_id.blank?
  end  
  
  def file_id_conditions
    [" ("+file_id_details+")", Document.find(:all,:conditions=>['file_id=?',file_id]).map(&:id)] unless file_id.blank?
  end
  
  def closed_conditions
      ["closed IS #{closed}"] unless from=='1' 
  end  
  
  
  
  def orders
    "letterxdt ASC"
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
