#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require 'remarkably/engines/html'

class UserController < AMSController

  include Remarkably::Common
  
  UserListingLength = 8
  
  map "/user"

  
  def profile(id = nil)
    @user = User[id] || User[1] # FIXME: For Testing
  end
  

  def index
    redirect UserController.r(:list, :start, 0)
  end


  def box(id = nil)
    if id
      id = id.to_i
      @user = User[id]
    end
  end

  
  def data(id)
    @user = User[id.to_i]
  end


  SOURCE_PATH = Rams::Source + "/app/public/data/user/1"
  
  def filetree
    str = "<ul class='filetree treeview treeview-black'>"
    Dir.chdir(SOURCE_PATH + "/..") do
      Dir['{1}'].map{|d| str << dir_listing(d) }
    end
    str + "</ul>"
  end
  
  
  def dir_listing(dir)
    str = '<li>'
    str << "<span class='folder'>#{dir}</span>"
    Dir.chdir(dir) do
      str << "<ul style='display:none'>"

      str << "<a href='##{File.expand_path('.').sub(SOURCE_PATH, '')}'></a>"
      
      Dir['*'].sort.each do |d|
        if File.directory?(d)
          str << dir_listing(d)
        else
          file = File.expand_path(d).sub(SOURCE_PATH, '')
          url = UserController.r(:file, :path => "#{File.expand_path('.').sub(SOURCE_PATH, '')}/#{d}")
          str << "<li><span class='file'>"
          str << "<a class='alink' href='#{url}'>#{d}</a>"
          str << "</span></li>"
        end
      end
      str << "</ul>"
    end
    str << "</li>"
  end
  private :dir_listing


  def browse
    @tree = filetree
  end


  def upload(uid)
    tempfile = request.params["userfile"][:tempfile]
    name = request.params["userfile"][:filename]    
    @user = User[uid.to_i]
    p @user.public_dir
    p Dir.pwd
    FileUtils.mkdir_p(@user.public_dir)
    FileUtils.copy(tempfile.path, @user.public_dir+"avatar.jpg")
  end


  def lookup
    q, timestamp = request[:q], request[:timestamp]
    emails = User.filter(:email.like("%#{q}%")).map{|u|
      [u.email, u.id].join("|")
    }
    emails.join("\n")
  end

  def update
    ps = request[:user]
    return "1" if ps.values.any?{|v| v.strip.size.zero?}
    if request.post?
      u = User.find(:email => ps['email'])
      ps.delete("pw1"); ps.delete("pw2")
      u.update(ps)
      if ua = request["user_loc"]      
        u.addresses.first.update(ua)
      end
      return "0"      
    end
    "1"
  end

  # # 0 allright
  # * 1 zuwenig ausgefüllt
  # * 2 pw != pw1
  def create
    ps = request[:user]
    return "1" if ps.values.any?{|v| v.strip.size.zero?}
    return "2" if ps['pw1'] != ps['pw2']
    pw = User.pwcrypt(ps['pw1'])
    if request.post?
      u = User.create(:email => ps['email'], :passwd => pw)
      if ua = request["user_loc"]
        ua.delete("user_id")
        u.add_address(addr=Address.create(ua))
      end
      return "0"
    end
    "1"
  end


  # FIXME: Add Page-Counter to view
  def list(garbage, start)
    au = User.all
    @start  = start.to_i || 0
    @limit = request.params["limit"] || UserListingLength
    p start, limit
    @user = au[@start .. (@start+@limit)-1] # FIXME: Do it with sequel!
    @uparted = @user.partition{|u| u.id % 2 == 0 }
  end

  
  def edit
    @user = User.sort_by{|u| u.email}
    @current_user = User[request.params["id"].to_i]
  end

  def value_for(f, v)
    if request.params['is_edit']
      user = User[request.params["id"].to_i]
      case f.to_s
      when "user"
        user.send(v.to_s)
      when "user_loc"
        begin
          user.addresses.first.send(v.to_s)
        rescue
          ""
        end
      end
    end
  end

  def search
    "search"
  end

  def me
    redirect UserController.r(:profile)
  end

  def tasks
  end

  def sidebar
  end

  private

  def make_browse_link(w = :+, start = 0, limit = UserListingLength)
    start = start.to_i
    start = start.send(w, UserController::UserListingLength)
    uc = User.count
    str = (w == :+) ? "Vorwärts" : "Zurück"
    if start < 0 or start >= uc

      "<span class='dark_text'>%s</span>" % str
    else
      "<a href='%s' title='Blättern: Start: #{start} ' class='alink plink'>%s</a>" % [UserController.r(:list, :start, start), str]
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
