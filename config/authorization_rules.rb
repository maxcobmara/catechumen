authorization do
  
  role :administration do
    has_permission_on :students,        :to => [:manage, :formforstudent]
    has_permission_on :staffs,          :to => [:manage, :borang_maklumat_staff]
    has_permission_on :attendances,     :to => [:manage, :approve]
    has_permission_on :leaveforstaffs,  :to => [:manage, :approve1, :approve2]
    has_permission_on [:leaveforstudents, :documents, :users, :ptbudgets],  :to => :manage

  end
  
  role :student do
    has_permission_on :students, :to => [:read, :update] do
      if_attribute :id => is {User.current_user.student_id}
    end
    has_permission_on :leaveforstudents, :to => [:manage] do
      if_attribute :student_id => is {User.current_user.student_id}
    end
    has_permission_on :leaveforstudents, :to => [:create]
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
  
  role :training_manager do
    has_permission_on :ptbudgets, :to => :manage
  end
  
  role :training_administration do
    has_permission_on :ptcourses, :to => :manage
  end
  
  role :warden do
    has_permission_on :leaveforstudents, :to => [:index, :show, :update, :approve] do
      if_attribute :studentsubmit => true
    end
  end
end
  
  privileges do
    privilege :approve,:includes => [:read, :update]
    privilege :manage, :includes => [:create, :read, :update, :delete, :core]
    privilege :core,   :includes => [:read]
    privilege :read,   :includes => [:index, :show]
    privilege :create, :includes => :new
    privilege :update, :includes => :edit
    privilege :delete, :includes => :destroy
    
  
  
  
end