class Kin < ActiveRecord::Base
  before_save  :titleize_name

  def titleize_name
    self.name = name.titleize
  end
  belongs_to :staff
  belongs_to :student
  validates_numericality_of :mykadno, :allow_blank => true
  validates_length_of       :mykadno, :is =>12, :allow_blank => true
  validates_format_of :name, :with => /^[a-zA-Z'`\/\.\@\ ]+$/, :message => I18n.t('activerecord.errors.messages.illegal_char') #add unwanted chars between bracket
  KTYPE = [
          #  Displayed       stored in db
          [ "Isteri",1 ],
          [ "Suami",2 ],
          [ "Ibu", 3 ],
          [ "Bapa", 4 ],
          [ "Anak", 5 ],
          [ "Nenek", 9 ],
          [ "Saudara Kandung", 11 ],
          [ "Penjaga", 12 ],
          [ "Bekas Isteri", 13 ],
          [ "Bekas Suami", 14 ],
          [ "Penjamin I", 98 ],
          [ "Penjamin II", 99 ]
   ]
end
