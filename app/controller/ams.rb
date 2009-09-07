#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class AMSController < Ramaze::Controller
  map    "/auth"
  layout "/simple_layout"
  

  def index
    redirect R(AMSController, :login)
  end
  
  def logout
    session[:username] = nil
    redirect R(AMSController, :login)
  end


  def session_user
    session[:username]
  end
  
  def login
    return false unless request.post?
    @title = "Authentifizierung"
    username = request[:login].strip
    password = request[:password].strip
    if check_auth(username, password)
      session[:logged_in] = true
      session[:username] = username
      redirect "/"
    else
      flash[:error] = "Benutzerkennung falsch."
    end
    redirect_referrer      
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
