class Loan < ActiveRecord::Base
  belongs_to :staff

  LTYPE = [
           #  Displayed       stored in db
           [ "Perumahan", 1 ],
           [ "Kenderaan", 2 ],
           [ "Komputer", 3 ],
           [ "Other", 4 ],
           [ "None", 99 ]
  ]
end
