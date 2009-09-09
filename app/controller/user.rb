#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class UserController < AMSController
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
  
  def list
    @user = User.all
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
end



=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
