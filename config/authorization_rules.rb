authorization do
  
  role :admini do
    has_permission_on :students, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :formforstudent]
  end
  
  role :student do
    has_permission_on :students, :to => [:index, :show, :edit, :update] do
      if_attribute :id => is {User.current_user.student_id}
    end
  end
  
  
end