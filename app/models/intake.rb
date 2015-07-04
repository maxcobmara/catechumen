class Intake < ActiveRecord::Base
  before_save :apply_month_year_if_nil
  
  belongs_to :programme, :foreign_key => 'programme_id'
  belongs_to :coordinator, :class_name => 'Staff', :foreign_key => 'staff_id'
  has_many   :students
  has_many   :weeklytimetables  #20March2013
  has_many   :lessonplans, :class_name => 'LessonPlan', :foreign_key=>'intake_id' #26March2013
  
  validates_presence_of :programme_id, :name, :description, :register_on
   
  def apply_month_year_if_nil
    if monthyear_intake==nil && register_on!=nil
      self.monthyear_intake = register_on.to_date.year.to_s+"-"+register_on.to_date.month.to_s+"-01"
    end
  end
  
  def self.search(search)
    if search
      programme = Programme.find(:all, :conditions => ['name ILIKE(?)', "%#{search}%"])
      if programme.count > 0
        programme_ids = programme.map(&:id)
        @intakes = Intake.find(:all, :conditions => ['programme_id IN(?)', programme_ids]).group_by{|t|t.name} 
      else
        @intakes = Intake.find(:all, :conditions => ['description ILIKE(?)', "%#{search}%"]).group_by{|t|t.name} 
      end
    else
      @intakes = Intake.all.group_by{|t|t.name} 
    end
    @intakes
  end
  
  #20March2013
  def group_with_intake_name
    "#{description}"+' ('+I18n.t('lesson_plan.intake_id')+" #{name}"+')'
  end  
  
  def programme_group_intake
    "#{description}"+" ("+"#{name}"+")"+" | "+"#{programme.name}"
  end
  
  def intake_programme
    "#{name}"+" | "+"#{programme.course_type}"+" - "+"#{programme.name}"
  end

  #25March2013==========
  def self.view_selected(intake_id)
    	@grouped = [] 
			@group = IntakeGroup.new("#{Intake.find(intake_id).programme.name}")
			@group << IntakeOption.new("#{intake_id}","#{Intake.find(intake_id).name}") 
	    @grouped << @group 
	    opt=[@grouped[0]]
      return opt
  end
  #25Match2013==========

  #24March2013==========
  IntakeOption = Struct.new(:id, :name)
  class IntakeGroup
    attr_reader :type_name, :options
    def initialize(name)
      @type_name = name
      @options = []
    end
    def <<(option)
      @options << option
    end
  end  
    #gd=[]
    #hh=[]
    #ii=[]
    @grouped=[]
    Intake.all.group_by{|t|t.programme_id}.each do |x, items|
      #gd << Programme.find(x).name
      @group =IntakeGroup.new("#{Programme.find(x).name}")
      items.each do |z|
        #ii<<z.id
        #hh<<z.name
        @group << IntakeOption.new("#{z.id}","#{z.name}")     #@group << IntakeOption.new("#{z.id}","#{z.name}")
      end
      @grouped << @group

    end

    intake_count = Intake.all.group_by{|t|t.programme_id}.count 
    1.upto(intake_count) do |y|
      
    end

    #--------------------------------------------------
    #group_a = IntakeGroup.new("#{gd[0]}")
    #group_a << IntakeOption.new("#{ii[0]}","#{hh[0]}")
    #group_a << IntakeOption.new(2,"Subject 2")

    #group_b = IntakeGroup.new("Diploma B")
    #group_b << IntakeOption.new(3,"Subject 3")
    #group_b << IntakeOption.new(4,"Subject 4")

    #group_c = IntakeGroup.new("Diploma C")
    #group_c << IntakeOption.new(5,"Subject 5")
    #group_c << IntakeOption.new(6,"Subject 6")

    #OPTIONS = [group_a,group_b,group_c]
    #--------------------------------------------------
    
    #OPTIONS = [@group]
    
    OPTIONS=[@grouped[0]] if intake_count == 1
    OPTIONS=[@grouped[0], @grouped[1]] if intake_count == 2
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2]] if intake_count == 3
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3] ] if intake_count == 4
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4]] if intake_count == 5
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5]] if intake_count == 6
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6]] if intake_count == 7
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7]] if intake_count == 8
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8]] if intake_count == 9
    OPTIONS=[@grouped[0], @grouped[1], @grouped[2], @grouped[3], @grouped[4], @grouped[5], @grouped[6], @grouped[7], @grouped[8], @grouped[9]] if intake_count == 10
   
  #24March2013==========
  
    
end
