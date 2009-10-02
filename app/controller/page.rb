#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class PageController < AMSController
  map     :/

  set_layout("layout" => [:index]) {|path, wish| not request.xhr? }
  helper :partial
  helper :auth

  before_all { login_required }

  USERS = {
    'demo' => Digest::SHA1.hexdigest('demo'),
    'entropie' => Digest::SHA1.hexdigest('lala'),
  }

  trait :auth_table => PageController::USERS

  def login
    redirect r(:auth, :login)
  end

  def logout
    redirect r(:auth, :logout)
  end
  
  def todo
    "asd"
  end
  
  def index
    @todos = session_user.todo
  end

  def dashboard
    @messages = session_user.messages.select{|msg| msg.read == 0} #.first 5
    @sent_messages = Message.filter(:from_id => session_user.id).reverse_order(:id).limit 5
    @read_messages = session_user.messages.select{|msg| msg.read == 1}.first 5
  end

  def gsidebar(*args)
    cls = self.class.controller_at("/#{args.first}")
    cm = if cls.kind_of?(Array) #or cls == PageController
           "/sidebar"
         else
           "#{cls.mapping}/sidebar/" + args[1..-1].map{|a| a.escape(:uri)}.join("/")
         end
    redirect cm
  end

  def sidebar(*args)
    "dashboard sb"
  end

  def a
    User.to_s
  end

  def b
    p request.xhr?
    "b"
  end
  def gg
    p request.xhr?
    "gg"
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
