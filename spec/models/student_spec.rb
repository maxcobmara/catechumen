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

require 'spec_helper'

describe Student do
  
  before { @student = Student.new(name: "Example User", email: "user@example.com") }
  subject { @student }

  it { should respond_to(:id_no1) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:telephone) }
  it { should respond_to(:status_type) }
  it { should respond_to(:sponsor_id) }
  it { should respond_to(:gender) }
  it { should respond_to(:marital_status) }
  it { should respond_to(:intake_id) }
  
  it { should be_valid }

  describe "when id_no1 is not present" do
    before { @student.id_no1 = " " }
    it { should_not be_valid }
  end
  
  describe "when id_no1 is too long" do
    before { @student.id_no1 = "a" * 13 }
    it { should_not be_valid }
  end
  
  describe "when id_no1 address is already taken" do
    before do
      student_with_same_id_no1 = @student.dup
      student_with_same_id_no1.save
    end

    it { should_not be_valid }
  end
  
  describe "when name is not present" do
    before { @student.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @student.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @student.email = invalid_address
        @student.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @student.email = valid_address
        @student.should be_valid
      end      
    end
  end
  
  describe "when email address is already taken" do
    before do
      student_with_same_email = @student.dup
      student_with_same_email.email = @student.email.upcase
      student_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "when telephone is not present" do
    before { @student.telephone = " " }
    it { should_not be_valid }
  end
  
  describe "when status_type is not present" do
    before { @student.status_type = " " }
    it { should_not be_valid }
  end
  
  describe "when sponsor_id is not present" do
    before { @student.sponsor_id = " " }
    it { should_not be_valid }
  end
  
  describe "when gender is not present" do
    before { @student.gender = " " }
    it { should_not be_valid }
  end
  
  describe "when marital_status is not present" do
    before { @student.marital_status = " " }
    it { should_not be_valid }
  end
  
  describe "when intake_id is not present" do
    before { @student.intake_id = " " }
    it { should_not be_valid }
  end
  
  
end
