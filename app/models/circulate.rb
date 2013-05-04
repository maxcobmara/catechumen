class Circulate < ActiveRecord::Base
  belongs_to :document
  belongs_to :circulate_name, :class_name => 'Staff', :foreign_key => "cc_staff"
  ACTION = [
        #  Displayed       stored in db
        [ "Tindakan", 1],
        [ "Makluman", 2 ],
        [ "Sila Bincang", 3 ]
   ]
end
