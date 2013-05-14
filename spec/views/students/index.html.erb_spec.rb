require 'spec_helper'

describe "students/index" do
  before(:each) do
    assign(:students, [
      stub_model(Student,
        :id_no1 => "Id No1",
        :id_no2 => "Id No2",
        :name => "Name",
        :email => "Email",
        :telephone => "Telephone",
        :gender => 1,
        :address => "MyText",
        :status_type => false,
        :marital_status => 2,
        :sponsor_id => 3,
        :programme_id => 4,
        :photo_file_name => "Photo File Name",
        :photo_content_type => "Photo Content Type",
        :photo_file_size => 5,
        :account_id => 6
      ),
      stub_model(Student,
        :id_no1 => "Id No1",
        :id_no2 => "Id No2",
        :name => "Name",
        :email => "Email",
        :telephone => "Telephone",
        :gender => 1,
        :address => "MyText",
        :status_type => false,
        :marital_status => 2,
        :sponsor_id => 3,
        :programme_id => 4,
        :photo_file_name => "Photo File Name",
        :photo_content_type => "Photo Content Type",
        :photo_file_size => 5,
        :account_id => 6
      )
    ])
  end

  it "renders a list of students" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Id No1".to_s, :count => 2
    assert_select "tr>td", :text => "Id No2".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
