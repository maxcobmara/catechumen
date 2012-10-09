# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


pages = Page.create([
  {:name => 'home', :title => 'Home', :admin => false, :navlabel => 'Home', :redirect => false}])
  
roles = Role.create([
  {:name => 'User',           :authname => 'user'},
  {:name => 'Administration', :authname => 'administration'},
  {:name => 'Student',        :authname => 'student'},
  {:name => 'Administration Staff', :authname => 'administration_staff'},
  {:name => 'Librarian',      :authname => 'librarian'},
  {:name => 'Staff',          :authname => 'staff'},
  {:name => 'Warden',         :authname => 'warden'},
  {:name => 'Training Administration',  :authname => 'training_administration'},
  {:name => 'Training Manager',     :authname => 'training_manager'},
  {:name => 'Asset Administrator',  :authname => 'asset_administrator'},
  {:name => 'Student Counsellor',   :authname => 'student_counsellor'},
  {:name => 'Facilities Administrator', :authname => 'facilities_administrator'},
  {:name => 'Lecturer',           :authname => 'lecturer'},
  {:name => 'Student Administrator',    :authname => 'student_administrator'},
  {:name => 'Staff Administrator',      :authname => 'staff_administrator'},
  {:name => 'E-Filing',           :authname => 'e_filing'},
  {:name => 'Programme Manager',  :authname => 'programme_manager'},
  {:name => 'Disciplinary Officer',     :authname => 'disciplinary_officer'},
  {:name => 'Guest',           :authname => 'guest'}
])
  


if !User.find_by_login('admin')
  u = User.create(:login => 'admin', :email => 'email@mail.com', 
              :password => 'changeme', :password_confirmation => 'changeme',
              :icno => '012345678901')
  Role.all.each { |role| u.roles << role }
end
