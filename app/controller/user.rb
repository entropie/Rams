#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class UserController < AMSController

  UserListingLength = 3
  
  map "/user"

  def profile(id)
    @user = User[id]
  end
  
  def index
    "user"
  end

  def create
    ps = request[:user]
    return "0" if ps.values.any?{|v| v.strip.size.zero?}
    return "-1" if ps['pw1'] != ps['pw2']
    pw = User.pwcrypt(ps['pw1'])
    if request.post?
      u = User.create(:email => ps['email'], :passwd => pw)
      if ua = request["user_loc"]
        addr = Address.create(ua.merge(:user_id => u.id))
      end
      "0"
    end
  end

  # FIXME: Add Page-Counter to view
  def list
    au = User.all
    start  = request.params["start"].to_i
    limit = request.params["limit"] || UserListingLength
    @user = au[start .. (start+limit)-1] # FIXME: Do it with sequel!
  end

  def edit
    "edit"
  end

  def search
    "search"
  end

  def me
    User[:email => session_user] || User[1].email
  end

  def tasks
  end
  
  def sidebar
  end

  private
  def make_browse_link(w = :+, limit = UserListingLength)
    start = request.params["start"].to_i
    start = start.send(w, UserController::UserListingLength)
    str = (w == :+) ? "Vorwärts" : "Zurück"
    if start < 0 or start >= User.size
      "<span class='dark_text'>%s</span>" % str
    else
      "<a href='%s' class='nohist alink plink'>%s</a>" % [UserController.r(:list, :start => start), str]
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
