class Student < ActiveRecord::Base
  attr_accessible :account_id, :address, :born_on, :email, :gender, :id_no1, :id_no2, :marital_status, :name, :photo_content_type, :photo_file_name, :photo_file_size, :photo_updated_at, :programme_id, :registered_on, :sponsor_id, :status_type, :telephone
end
