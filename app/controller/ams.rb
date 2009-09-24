#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#


class AMSController < Ramaze::Controller
  engine :Haml

  set_layout_except 'layout' => [:login, :logout]
  set_layout        'simple_layout' => [:login, :logout]

  include Rams::Database::Tables
  
  before(){
    login_required
  }

  ControllerList = []
  
  def self.inherited(cls)
    log cls
    ControllerList << cls
  end

  def self.controllerr
    ControllerList
  end

  def self.controller_at(path)
    controllerr.each do |c|
      return c if c.mapping == path
    end
  end

  def session_user
    
    User.find(:email => session[:username]) if session
  end
  
  def login_required
    flash[:error] = 'login required to view that page' unless logged_in?
    super
  end

  private

  def Icon(name, title, size = 16, color = :orange)
    file = "/img/ics/#{name}_#{color}_#{size}.png"
    "<img src='%s' title='%s' alt='%s' height='%s' width='%s'/>" % [file, title, title, size, size]
  end
  def Mcon(name, title, size = 32)
    file = "/img/mics/#{name}.png"
    "<img src='%s' title='%s' alt='%s' height='%s' width='%s'/>" % [file, title, title, size, size]
  end

  def logged_in?
    check_auth(session[:username].to_s, session[:password].to_s)
  end

  def check_auth(email, pass)
    return false if (not email or email.empty?) and (not pass or pass.empty?)
    if pass.size == 32
      pw = pass
    else
      pw = User.pwcrypt(pass)
    end
    if usr = User[:email => email, :passwd => pw]
      true
    else
      flash[:error] = 'Falscher Benutzername und/oder Passwort.'      
      false
    end
  end  

  def Thumbnail(file, x, y = nil)
    ImageScience.with_image(file) do |img|
      img.thumbnail(x) do |thumb|
        dir, fname = File.dirname(file), "thumb_" + File.basename(file).to_s
        thumb.save(nfile = File.join(dir, fname))
        log "Thumbnail: #{nfile}"
      end
    end
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
