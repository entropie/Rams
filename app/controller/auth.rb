#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class AuthController < AMSController

  map "/auth"
  
  def login
    return false unless request.post?
    @title = "Authentifizierung"
    username = request[:login].strip
    password = request[:password].strip
    p check_auth(username, password)
    if check_auth(username, password)
      session[:logged_in] = true
      session[:username] = username
      redirect "/"
    else
      flash[:error] = "Benutzerkennung falsch."
    end
    redirect PageController.r(:/)
  end
  
  def logout
    session[:username] = nil
    redirect AMSController.r(:login)
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
