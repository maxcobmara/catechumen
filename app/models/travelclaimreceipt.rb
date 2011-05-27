class Travelclaimreceipt < ActiveRecord::Base
  belongs_to :travelclaim
  
  RECEIPTTYPE = [
        #  Displayed       stored in db
        [ "Teksi",1 ],
        [ "Bas",2 ],
        [ "Keretapi",3 ],
        [ "Feri",4 ],
        [ "Kapal Terbang",5 ],
        [ "Tol",6 ],
        [ "Tempat Letak Kereta",7 ],
        [ "Dobi",8 ],
        [ "Pos",9 ],
        [ "Telefon/Teleks/Fax",10 ],
  ]
end
