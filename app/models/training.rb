class Training < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_combo_code
  has_ancestry :cache_depth => true
  
  
  
  def set_combo_code
    if ancestry_depth == 0
      self.combo_code = code
    else
      self.combo_code = parent.combo_code + "-" + code
    end
  end
  
  def tree_nd
    if is_root?
      gls = ""
    else
      gls = "class=\"child-of-node-#{parent_id}\""
    end
    gls
  end
  
  
  
  COURSE_STATUS = [
       #  Displayed       stored in db
       [ "Major",     1 ],
       [ "Minor",     2 ],
       [ "Elective",  3 ]
  ]
  
  DURATION_TYPES = [
       #  Displayed       stored in db
       [ "Days",       1 ],
       [ "Weeks",      7 ],
       [ "Months",     30 ],
       [ "Years",      365 ]
  ]
end
