class JavascriptsController < ApplicationController
  def dynamic_staffemployschemes
    @staffemployschemes = Staffemployscheme.find(:all)
  end
  
  def dynamic_subjects
    @subjects = @Subject.find(:all)
  end
end
