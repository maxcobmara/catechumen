require 'spec_helper'

describe "students/show" do
  before(:each) do
    @student = assign(:student, stub_model(Student,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Id No1/)
    rendered.should match(/Id No2/)
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/Telephone/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Photo File Name/)
    rendered.should match(/Photo Content Type/)
    rendered.should match(/5/)
    rendered.should match(/6/)
  end
end
