class Addbook < ActiveRecord::Base
  has_many :suppliers,    :class_name => 'Asset', :foreign_key => 'supplier_id'
  has_many :manufacturers,:class_name => 'Asset', :foreign_key => 'manufacturer_id'
  has_many :books,                                :foreign_key => 'supplier_id'
  has_many :ptcourses,                            :foreign_key => 'provider_id'
  has_many :maintainers,  :class_name => 'Maint', :foreign_key => 'maintainer_id'
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name ILIKE ?', "#{search}%"])
    else
      all
    end
  end
  
  
end
