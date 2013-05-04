class SktTarget < ActiveRecord::Base
  belongs_to :skt_staff
  
  has_many :skt_achives, :foreign_key => 'skt_target_id', :dependent => :destroy
  accepts_nested_attributes_for :skt_achives, :reject_if => lambda { |a| a[:performance].blank? }, :allow_destroy =>true
  
  STATUS = [
         #  Displayed       stored in db
         [ "SKT yang ditetapkan",1],
         [ "SKT yang ditambah",2],
         [ "SKT yang digugurkan",3]

   ]
end
