authorization do
  
  role :admini do
    has_permission_on :students,    :to => [:index, :show, :new, :create, :edit, :update, :destroy, :formforstudent]
    has_permission_on :staffs,      :to => [:index, :show, :new, :create, :edit, :update, :destroy, :borang_maklumat_staff]
    has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :approve]
    has_permission_on :documents,   :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :leaveforstaffs, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :approve1, :approve2]

  end
  
  role :student do
    has_permission_on :students, :to => [:index, :show, :edit, :update] do
      if_attribute :id => is {User.current_user.student_id}
    end
  end
  
  role :staff do
    has_permission_on :staffs, :to => [:index, :show, :edit, :update] do
      if_attribute :id => is {User.current_user.staff_id}
    end
  end
  
  role :staff do
    has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :approve, :update] do
        if_attribute :approve_id => is {User.current_user.staff_id}
    end
  end
  
  role :staff do
    has_permission_on :leaveforstaffs, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:index, :show, :approve1, :update] do
        if_attribute :approval1_id => is {User.current_user.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:index, :show, :approve2, :update] do
        if_attribute :approval2_id => is {User.current_user.staff_id}
    end
  end
  
  
end