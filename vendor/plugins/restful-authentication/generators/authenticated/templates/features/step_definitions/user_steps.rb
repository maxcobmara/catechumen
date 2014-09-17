RE_Login      = %r{(?:(?:the )? *(\w+) *)}
RE_Login_TYPE = %r{(?: *(\w+)? *)}

#
# Setting
#

Given "an anonymous user" do
  log_out!
end

Given "$an $login_type user with $attributes" do |_, login_type, attributes|
  create_login! login_type, attributes.to_hash_from_story
end

Given "$an $login_type user named '$login'" do |_, login_type, login|
  create_login! login_type, named_login(login)
end

Given "$an $login_type user logged in as '$login'" do |_, login_type, login|
  create_login! login_type, named_login(login)
  log_in_login!
end

Given "$actor is logged in" do |_, login|
  log_in_login! @login_params || named_login(login)
end

Given "there is no $login_type user named '$login'" do |_, login|
  @login = Login.find_by_login(login)
  @login.destroy! if @login
  @login.should be_nil
end

#
# Actions
#
When "$actor logs out" do
  log_out
end

When "$actor registers an account as the preloaded '$login'" do |_, login|
  user = named_login(login)
  user['password_confirmation'] = user['password']
  create_login user
end

When "$actor registers an account with $attributes" do |_, attributes|
  create_login attributes.to_hash_from_story
end


When "$actor logs in with $attributes" do |_, attributes|
  log_in_login attributes.to_hash_from_story
end

#
# Result
#
Then "$actor should be invited to sign in" do |_|
  response.should render_template('/sessions/new')
end

Then "$actor should not be logged in" do |_|
  controller.logged_in?.should_not be_true
end

Then "$login should be logged in" do |login|
  controller.logged_in?.should be_true
  controller.current_login.should === @login
  controller.current_login.login.should == login
end

def named_login login
  login_params = {
    'admin'   => {'id' => 1, 'login' => 'addie', 'password' => '1234addie', 'email' => 'admin@example.com',       },
    'oona'    => {          'login' => 'oona',   'password' => '1234oona',  'email' => 'unactivated@example.com'},
    'reggie'  => {          'login' => 'reggie', 'password' => 'monkey',    'email' => 'registered@example.com' },
    }
  login_params[login.downcase]
end

#
# Login account actions.
#
# The ! methods are 'just get the job done'.  It's true, they do some testing of
# their own -- thus un-DRY'ing tests that do and should live in the user account
# stories -- but the repetition is ultimately important so that a faulty test setup
# fails early.
#

def log_out
  get '/sessions/destroy'
end

def log_out!
  log_out
  response.should redirect_to('/')
  follow_redirect!
end

def create_login(login_params={})
  @login_params       ||= login_params
  post "/users", :user => login_params
  @login = Login.find_by_login(login_params['login'])
end

def create_login!(login_type, login_params)
  login_params['password_confirmation'] ||= login_params['password'] ||= login_params['password']
  create_login login_params
  response.should redirect_to('/')
  follow_redirect!

end



def log_in_login login_params=nil
  @login_params ||= login_params
  login_params  ||= @login_params
  post "/session", login_params
  @login = Login.find_by_login(login_params['login'])
  controller.current_login
end

def log_in_login! *args
  log_in_login *args
  response.should redirect_to('/')
  follow_redirect!
  response.should have_flash("notice", /Logged in successfully/)
end
