require 'spec_helper'

describe "students/edit" do
  before(:each) do
    @student = assign(:student, stub_model(Student,
      :id_no1 => "MyString",
      :id_no2 => "MyString",
      :name => "MyString",
      :email => "MyString",
      :telephone => "MyString",
      :gender => 1,
      :address => "MyText",
      :status_type => false,
      :marital_status => 1,
      :sponsor_id => 1,
      :programme_id => 1,
      :photo_file_name => "MyString",
      :photo_content_type => "MyString",
      :photo_file_size => 1,
      :account_id => 1
    ))
  end

  it "renders the edit student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => students_path(@student), :method => "post" do
      assert_select "input#student_id_no1", :name => "student[id_no1]"
      assert_select "input#student_id_no2", :name => "student[id_no2]"
      assert_select "input#student_name", :name => "student[name]"
      assert_select "input#student_email", :name => "student[email]"
      assert_select "input#student_telephone", :name => "student[telephone]"
      assert_select "input#student_gender", :name => "student[gender]"
      assert_select "textarea#student_address", :name => "student[address]"
      assert_select "input#student_status_type", :name => "student[status_type]"
      assert_select "input#student_marital_status", :name => "student[marital_status]"
      assert_select "input#student_sponsor_id", :name => "student[sponsor_id]"
      assert_select "input#student_programme_id", :name => "student[programme_id]"
      assert_select "input#student_photo_file_name", :name => "student[photo_file_name]"
      assert_select "input#student_photo_content_type", :name => "student[photo_content_type]"
      assert_select "input#student_photo_file_size", :name => "student[photo_file_size]"
      assert_select "input#student_account_id", :name => "student[account_id]"
    end
  end
end
