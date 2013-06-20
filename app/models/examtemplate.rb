class Examtemplate < ActiveRecord::Base
  belongs_to :exam, :foreign_key => "exam_id"
  
  named_scope :mcqq, :conditions => {:questiontype => 'MCQ'}
  named_scope :meqq, :conditions => {:questiontype => 'MEQ'}      
  named_scope :seqq, :conditions => {:questiontype => 'SEQ'} 	  
  named_scope :acqq, :conditions => {:questiontype => 'ACQ'}
  named_scope :osce, :conditions => {:questiontype => 'OSCI'}
  named_scope :ospe, :conditions => {:questiontype => 'OSCII'}
  named_scope :viva, :conditions => {:questiontype => 'VIVA'}
  named_scope :truefalse, :conditions => {:questiontype => 'TRUEFALSE'}
end
