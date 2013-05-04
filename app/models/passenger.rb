class Passenger < ActiveRecord::Base
belongs_to :bookingvehicle
belongs_to :staff
end
