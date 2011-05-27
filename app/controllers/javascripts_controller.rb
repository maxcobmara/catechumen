class JavascriptsController < ApplicationController
  def dynamic_staffemployschemes
    @staffemployschemes = Staffemployscheme.find(:all)
  end
end
