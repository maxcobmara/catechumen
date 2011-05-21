authorization do
  
  role :admini do
    has_permission_on :students,    :to => [:index, :show, :new, :create, :edit, :update, :destroy, :formforstudent]
    has_permission_on :staffs,      :to => [:index, :show, :new, :create, :edit, :update, :destroy, :borang_maklumat_staff]
    has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :approve]
    has_permission_on :leaveforstaffs, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :approve1, :approve2]
    has_permission_on [:leaveforstudents, :documents, :users],  :to => [:index, :show, :new, :create, :edit, :update, :destroy]

  end
  
  role :student do
    has_permission_on :students, :to => [:index, :show, :edit, :update] do
      if_attribute :id => is {User.current_user.student_id}
    end
    has_permission_on :leaveforstudents, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :student_id => is {User.current_user.student_id}
    end
    has_permission_on :leaveforstudents, :to => [:new, :create]
  end
  
  role :staff do
    has_permission_on :staffs, :to => [:index, :show, :edit, :update] do
      if_attribute :id => is {User.current_user.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :approve, :update] do
        if_attribute :approve_id => is {User.current_user.staff_id}
    end
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
  
  role :warden do
    has_permission_on :leaveforstudents, :to => [:index, :show, :update, :approve] do
      if_attribute :studentsubmit => true
    end
  end
  
  
end