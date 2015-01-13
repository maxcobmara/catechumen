class Examtemplate < ActiveRecord::Base
  belongs_to :exam, :foreign_key => "exam_id"
  
  named_scope :mcqq, :conditions => {:questiontype => 'MCQ'}
  named_scope :meqq, :conditions => {:questiontype => 'MEQ'}      
  named_scope :seqq, :conditions => {:questiontype => 'SEQ'} 
  named_scope :acqq, :conditions => {:questiontype => 'ACQ'}
  named_scope :osci2q, :conditions => {:questiontype => 'OSCI'}
  named_scope :osci3q, :conditions => {:questiontype => 'OSCII'}
  named_scope :osceq, :conditions => {:questiontype => 'OSCE'}
  named_scope :ospeq, :conditions => {:questiontype => 'OSPE'}
  named_scope :vivaq, :conditions => {:questiontype => 'VIVA'}
  named_scope :truefalseq, :conditions => {:questiontype => 'TRUEFALSE'}
end
