class JavascriptsController < ApplicationController
  def dynamic_staffemployschemes
    @staffemployschemes = Staffemployscheme.find(:all)
  end
  
  def dynamic_subjects
    @subjects = Programme.at_depth(2)#Subject.find(:all) #@Subject.find(:all) - 24March2013
  end
end
