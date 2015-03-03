class StationeryUse < ActiveRecord::Base
 belongs_to :stationery
 belongs_to :issuer,       :class_name => 'Staff', :foreign_key => 'issuedby'
 belongs_to :receiver,       :class_name => 'Staff', :foreign_key => 'receivedby'
 
 validates_presence_of :issuedby, :receivedby, :issuedate, :quantity
 validates_format_of      :quantity, :with => /[1-9]/, :message => I18n.t('activerecord.errors.messages.invalid')
end