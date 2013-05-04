class Instructor < ActiveRecord::Base
  before_save :varmyass
  belongs_to :checker, :class_name => 'Position', :foreign_key => 'check_qc'
  belongs_to :instructor_name, :class_name => 'Staff', :foreign_key => 'staff_id'
  
  SCORE = [
        #  Displayed       stored in db
        [ "0",0 ],
        [ "1",1 ],
        [ "2", 2 ]
   ]
    
  def varmyass
     self.total_mark	= totalscore
   end

    def totalscore
    	  q1 + q2 + q3 + q4 + q5 + q6 + q7 + q8 + q9 + q10 + 
    	  q11 + q12 + q13 + q14 + q15 + q16 + q17 + q18 + q19 + q20 + 
    	  q21 + q22 + q23 + q24 + q25 + q26 + q27 + q28 + q29 + q30 + 
    	  q31 + q32 + q33 + q34 + q35 + q36 + q37 + q38 + q39 + q40 + 
    	  q41 + q42 + q43 + q44 + q45 + q46 + q47 + q48
    end
    
	#20Feb2013-Feature#11
	def self.totalmark(m,i)
	  @arraymark = []
	
      @arraymark << m if i.q1==m  
	  @arraymark << m if i.q2==m  
	  @arraymark << m if i.q3==m  
	  @arraymark << m if i.q4==m  
	  @arraymark << m if i.q5==m  
	  @arraymark << m if i.q6==m  
	  @arraymark << m if i.q7==m  
	  @arraymark << m if i.q8==m  
	  @arraymark << m if i.q9==m 
	  @arraymark << m if i.q10==m  
	  @arraymark << m if i.q11==m  
	  @arraymark << m if i.q12==m  
	  @arraymark << m if i.q13==m  
	  @arraymark << m if i.q14==m  
	  @arraymark << m if i.q15==m  
	  @arraymark << m if i.q16==m  
	  @arraymark << m if i.q17==m  
	  @arraymark << m if i.q18==m  
	  @arraymark << m if i.q19==m  
	  @arraymark << m if i.q20==m  
	  @arraymark << m if i.q21==m  
	  @arraymark << m if i.q22==m  
	  @arraymark << m if i.q23==m  
	  @arraymark << m if i.q24==m  
	  @arraymark << m if i.q25==m  
	  @arraymark << m if i.q26==m  
	  @arraymark << m if i.q27==m  
	  @arraymark << m if i.q28==m  
	  @arraymark << m if i.q29==m  
	  @arraymark << m if i.q30==m  
	  @arraymark << m if i.q31==m  
	  @arraymark << m if i.q32==m  
	  @arraymark << m if i.q33==m  
	  @arraymark << m if i.q34==m  
	  @arraymark << m if i.q35==m  
	  @arraymark << m if i.q36==m  
	  @arraymark << m if i.q37==m  
	  @arraymark << m if i.q38==m  
	  @arraymark << m if i.q39==m  
	  @arraymark << m if i.q40==m  
	  @arraymark << m if i.q41==m  
	  @arraymark << m if i.q42==m  
	  @arraymark << m if i.q43==m 
	  @arraymark << m if i.q44==m 
	  @arraymark << m if i.q45==m  
	  @arraymark << m if i.q46==m  
	  @arraymark << m if i.q47==m 
	  @arraymark << m if i.q48==m

	  @totalmark = 0
	  @arraymark.each do |val|
			@totalmark+=val
	  end
	return @totalmark
	end

end
