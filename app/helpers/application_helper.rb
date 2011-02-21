# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ringgols(money)
    number_to_currency(money, :unit => "RM ", :separator => ".", :delimiter => ",", :precision => 2)
  end
end
