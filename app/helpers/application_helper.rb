# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ringgols(money)
    number_to_currency(money, :unit => "RM ", :separator => ".", :delimiter => ",", :precision => 2)
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
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
  
  #-------------- 15 August 2012 - given by Shima--------------------#
  # app/helpers/application_helper.rb --> date:9th March 2012 --> source : http://groups.google.com/group/rubyonrails-talk/browse_thread/thread/fbaffb284d7e504c/d1e2047bd214ed1b
  # title : Using observe_field on an field inside a fields_for Options.
  def sanitized_object_name(object_name) 
    object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/,"_").sub(/_$/,"") 
  end 
  def sanitized_method_name(method_name)                   # original source --> def sanitized_method_nam(method_name) 
    method_name.sub(/\?$/, "") 
  end 
  def form_tag_id(object_name, method_name)                 # original source --> def form_tag_id(object_name, method_name) 
    "#{sanitized_object_name(object_name.to_s)}_#{sanitized_method_name(method_name.to_s)}" 
  end
  
  #---------------23 Apr 2012 --------------------#
  
end
