class TimetableWeekDay < ActiveRecord::Base
  has_many :time_table_entries
end
