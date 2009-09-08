#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class AMSController < Ramaze::Controller
  engine :Haml
  #layout "/layout",        [ :lala]
  #layout("simple_layout")
  set_layout_except 'layout' => [:login, :logout]
  set_layout        'simple_layout' => [:login, :logout]
  #layout :layout
  
  # before(:index, :id){
  #   login_required
  # }

  def session_user
    session[:username]
  end
  
  def login_required
    flash[:error] = 'login required to view that page' unless logged_in?
    super
  end

  private

  def logged_in?
    check_auth(session[:username].to_s, session[:password].to_s)
  end

  def check_auth(email, pass)
    # return false if (not email or email.empty?) and (not pass or pass.empty?)
    # if pass.size == 32
    #   pw = pass
    # else
    #   pw = User.pwcrypt(pass)
    # end
    # if User[:email => email, :passwd => pw].nil?
    #   flash[:error] = 'Falscher Benutzername und/oder Passwort.'
    #   false
    # else
    #   true
    # end
    true if email == "entropie" && pass == "test"
  end  
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
