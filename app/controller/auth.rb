#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class AuthController < AMSController

  map "/auth"
  
  def login
    unless request.post?

    else
      @title = "Authentifizierung"
      username = request[:username].strip
      password = request[:password].strip
      if check_auth(username, password)
        session[:logged_in] = true
        session[:username] = username
        redirect PageController.r(:/)
      else
        flash[:error] = "Unbekannter Benutzer oder falsches Passwort."
      end
      redirect AuthController.r(:login)
    end
  end
  
  def logout
    session[:username] = nil
    redirect AuthController.r(:login)
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
