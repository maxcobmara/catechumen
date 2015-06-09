class Mycpd < ActiveRecord::Base
  belongs_to :cpd_owner, :class_name => 'Staff', :foreign_key => 'staff_id'
  validates_presence_of :cpd_year, :cpd_value
  validates_uniqueness_of :cpd_year, :scope => :staff_id, :message => I18n.t('training.uniq_msg')
end