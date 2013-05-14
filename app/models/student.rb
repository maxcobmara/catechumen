# == Schema Information
#
# Table name: students
#
#  id                 :integer          not null, primary key
#  id_no1             :string(255)
#  id_no2             :string(255)
#  name               :string(255)
#  email              :string(255)
#  telephone          :string(255)
#  gender             :integer
#  born_on            :date
#  registered_on      :date
#  address            :text
#  status_type        :boolean
#  marital_status     :integer
#  sponsor_id         :integer
#  programme_id       :integer          default(0), not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  account_id         :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Student < ActiveRecord::Base
  attr_accessible :account_id, :address, :born_on, :email, :gender, :id_no1, :id_no2, :marital_status, :name, :photo_content_type, :photo_file_name, :photo_file_size, :photo_updated_at, :programme_id, :registered_on, :sponsor_id, :status_type, :telephone

  before_save { |user| user.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :id_no1,  presence: true, length: { maximum: 12 }, uniqueness: true
  validates :email,   presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, :telephone, :status_type, :sponsor_id, :gender, :marital_status, :intake_id, presence: true
 
end