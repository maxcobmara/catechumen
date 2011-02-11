class Appraisal < ActiveRecord::Base
  belongs_to :appraisedstaff, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :ppp, :class_name => 'Staff', :foreign_key => 'ppp_id'
  
  before_save :varmyass
  
  validates_presence_of :staff_id
  
  def varmyass
    self.ppptotals	= ppptotal
    self.ppktotals	= ppktotal
    self.ppppercent	= pppperc
    self.ppkpercent	= ppkperc
    self.pointsaverage = ppaverage
  end
  
  # save calculations for ppp
    
  def ppptotal
    pppquantity + pppquality + pppontime + pppeffective + 
    pppknowledge + ppprules + pppcommunication +
    pppleader + pppmanage + pppdiscipline + pppproactive + ppprelate + 
    pppparttwo
  end
  
  def ppktotal
    ppkquantity + ppkquality + ppkontime + ppkeffective + 
    ppkknowledge + ppkrules + ppkcommunication +
    ppkleader + ppkmanage + ppkdisipline + ppkproactive + ppkrelate + 
    ppkparttwo
  end
  
  def pppperc
    (((pppquantity + pppquality + pppontime + pppeffective)/100)*50) +
    (((pppknowledge + ppprules + pppcommunication)/100)*20) +
    (((pppleader + pppmanage + pppdiscipline + pppproactive + ppprelate)/100)*20) +
    (((pppparttwo)/100)*10)
  end
  
  def ppkperc
    (((ppkquantity + ppkquality + ppkontime + ppkeffective)/100)*50) +
    (((ppkknowledge + ppkrules + ppkcommunication)/100)*20) +
    (((ppkleader + ppkmanage + ppkdisipline + ppkproactive + ppkrelate)/100)*20) +
    (((ppkparttwo)/100)*10)
  end
  
  def ppaverage
    (pppperc + ppkperc)/2
  end
  


    

  
  # code for repeating field qualification
   has_many :evactivities, :dependent => :destroy

   def new_evactivity_attributes=(evactivity_attributes)
     evactivity_attributes.each do |attributes|
       evactivities.build(attributes)
     end
   end

   after_update :save_evactivities

   def existing_evactivity_attributes=(evactivity_attributes)
     evactivities.reject(&:new_record?).each do |evactivity|
       attributes = evactivity_attributes[evactivity.id.to_s]
       if attributes
         evactivity.attributes = attributes
       else
         evactivities.delete(evactivity)
       end
     end
   end

   def save_evactivities
     evactivities.each do |evactivity|
       evactivity.save(false)
     end
   end
   
   # code for repeating field straining
    has_many :strainings, :dependent => :destroy

    def new_straining_attributes=(straining_attributes)
      strainings_attributes.each do |attributes|
        strainings.build(attributes)
      end
    end

    after_update :save_strainings

    def existing_strainings_attributes=(strainings_attributes)
      strainings.reject(&:new_record?).each do |straining|
        attributes = straining_attributes[straining.id.to_s]
        if attributes
          straining.attributes = attributes
        else
          strainings.delete(straining)
        end
      end
    end

    def save_strainings
      strainings.each do |straining|
        straining.save(false)
      end
    end
  
  
# code for repeating field trainneed
       has_many :trainneed, :dependent => :destroy

        def new_trainneed_attributes=(trainneed_attributes)
          trainneed_attributes.each do |attributes|
            trainneeds.build(attributes)
          end
        end

      after_update :save_trainneeds

        def existing_trainneed_attributes=(trainneed_attributes)
          trainneeds.reject(&:new_record?).each do |trainneed|
            attributes = trainneed_attributes[trainneed.id.to_s]
            if attributes
              trainneed.attributes = attributes
            else
              trainneeds.delete(trainneed)
            end
          end
        end

        def save_trainneeds
          trainneeds.each do |trainneed|
            trainneed.save(false)
          end
        end
end
