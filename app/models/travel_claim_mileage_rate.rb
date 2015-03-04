class TravelClaimMileageRate < ActiveRecord::Base
  
  def self.km_by_group(km, group)
    if group == 'A'
      find(:first, :conditions => ['km_high=?',km]).a_group
    elsif group == 'B'
      find(:first, :conditions => ['km_high=?',km]).b_group
    elsif group == 'C'
      find(:first, :conditions => ['km_high=?',km]).c_group
    elsif group == 'D'
      find(:first, :conditions => ['km_high=?',km]).d_group
    elsif group == 'E'
      find(:first, :conditions => ['km_high=?',km]).e_group
    end
  end
  
end
