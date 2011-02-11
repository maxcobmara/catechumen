module StaffsHelper
  
  def add_qualification_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :qualifications, :partial => 'qualification', :object => Qualification.new
    end
  end
  
  def add_kin_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :kins, :partial => 'kin', :object => Kin.new
    end
  end
  
  def add_loan_link(name)
     link_to_function name do |page|
       page.insert_html :bottom, :loans, :partial => 'loan', :object => Loan.new
     end
   end
  
end
