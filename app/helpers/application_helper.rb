# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ringgols(money)
    number_to_currency(money, :unit => "RM ", :separator => ".", :delimiter => ",", :precision => 2)
  end
  
  def select_tag_for_filter(model, nvpairs, params)
    options = { :query => params[:query] }
    _url = url_for(eval("#{model}_url(options)"))
    _html = %{<label for="show">Show:</label>}
    _html << %{<select name="show" id="show"}
    _html << %{onchange="window.location='#{_url}' + '?show=' + this.value">}
    nvpairs.each do |pair|
      _html << %{<option value="#{pair[:scope]}"}
      if params[:show] == pair[:scope] || ((params[:show].nil? || params[:show].empty?) && pair[:scope] == "all")
        _html << %{ selected="selected"}
      end
      _html << %{>#{pair[:label]}}
      _html << %{</option>}
    end
    _html << %{</select>}
  end
  
end
