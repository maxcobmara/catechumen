class SktAchive < ActiveRecord::Base
  belongs_to :skt_target, :foreign_key => 'skt_target_id'
  
  PERFORM = [
        #  Displayed       stored in db
        [ "Kuantiti",1],
        [ "Kualiti",2 ],
        [ "Masa",3 ],
        [ "Kos",4 ],
  ]
end
