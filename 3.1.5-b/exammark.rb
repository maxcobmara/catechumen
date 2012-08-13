class Exammark < ActiveRecord::Base
 
  belongs_to :exampaper, :class_name =>'Exammaker', :foreign_key => 'exammaker_id'
  belongs_to :studentmark, :class_name => 'Student', :foreign_key => 'student_id'
  has_many :marks, :dependent => :destroy                                                     
  accepts_nested_attributes_for :marks#, :reject_if => lambda { |a| a[:mark].blank? }   #use of validates_presence_of in mark model
  validates_presence_of :exammaker_id, :student_id#, :total_marks
  validates_uniqueness_of :student_id, :scope => :exammaker_id, :message => " - Mark of this subject for selected student already exist. Please edit/delete existing mark accordingly."
  validate :student_id_is_compulsory 
  #validates_numericality_of :total_marks #ref: :http:railsforum.com/viewtopic.php?id=12573 (burttonboarder)
  attr_accessor :total_marks

  def total_marks
	  if self.id	
      Mark.sum(:mark, :conditions => ["exammark_id=?", self.id])
    else
      @total_marks	#any input by user will be ignored either edit form or new (including re-submission-invalid data)
					          #value assigned from partial..(1) single entry(_form.html.erb-line 44-47) (2) multiple entry(_form_by_paper.html.erb-line88-91)
    end
  end

  def self.set_params_value(exammark_list,datatype_for)
    @count_exammark = 0
    exammark_list.each do |exammarkline|
      if @count_exammark == 0 
			  if datatype_for == 0
				   return exammarkline.exammaker_id.to_i              # working format - @try = gradeline.exam1marks.to_i.to_s
        end
      end
      @count_exammark+=1
    end  
  end
  
  def self.set_total_marks(exammark_list,record_no,examquestions_count)
    @count_exammark = 0
    @value_total = 0
    exammark_list.each do |exammarkline|
      if @count_exammark == record_no.to_i
        0.upto(examquestions_count-1) do |counter|
          @value_total = @value_total + exammarkline.marks[counter].mark
        end                            
        return @value_total
      end  
      @count_exammark+=1
    end
  end

  def self.set_error_messages(exammark_list)
	  @exammarkerrors = []
	  @exammarkerrors2 = []
	  @exammarkerrors_full = []
    @errors_qty = 0
    exammark_list.each do |exammarksub|
      exammarksub.errors.each do |key,value|
          @key2 = key
          #@exammarkerrors << '<b>'+I18n.t('activerecord.attributes.exammark.'+key)+'</b>'+' '+value+'<br>'
			    @exammarkerrors << '<b>'+I18n.t('activerecord.attributes.exammark.'+key)+'</b>'+' '+value+'<br>'
			    @errors_qty+=1
		  end 	# end of exammarksub.errors.each do |key,value|
	  end		# end of exammark_list.each do |exammarksub|
    if @errors_qty == 1
			  @exammarkerrors2 <<'<b>'+@errors_qty.to_s+' error '
	  elsif @errors_qty > 1
			  @exammarkerrors2 <<'<b>'+@errors_qty.to_s+' errors '
	  end
	  @exammarkerrors2 << 'prohibited this record from being saved</b><br><br>'
	  @exammarkerrors_full << @exammarkerrors2.to_s+@exammarkerrors.to_s
    return @exammarkerrors_full
  end  
  
  def self.sum_marks(all_marks)
    @sum_of_marks = 0.0
    0.upto(all_marks.count-1) do |counter|
      @sum_of_marks = @sum_of_marks+all_marks[counter.to_s]["mark"].to_f
    end
    return @sum_of_marks
  end

  protected
    def student_id_is_compulsory 
      errors.add(:student_id, I18n.t('activerecord.errors.messages.must_be_selected')) if student_id.nil? || student_id == 0 || student_id.blank? || student_id == '0' 
    end
    
    def total_marks_must_be_at_least_a_zero
      errors.add(:total_marks, I18n.t('activerecord.errors.messages.must_be_at_least_a_zero')) if total_marks.nil? || total_marks.blank? || total_marks < 0
    end
end
