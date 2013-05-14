require 'spec_helper'

describe "Student Pages" do
  
  subject { page }
  
  describe "info page" do
    let(:student)  { FactoryGirl.create(:student) }
    before { visit student_path(student) }
    it { should have_selector('h1',    text: student.name) }
    it { should have_selector('title', text: student.name) }
  end
end
