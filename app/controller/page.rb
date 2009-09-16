#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class PageController < AMSController
  map     :/

  set_layout("layout" => [:index]) {|path, wish| not request.xhr? }
  helper :partial


  def todo
    "asd"
  end
  
  def index
    @todos = session_user.todo
  end

  def dashboard
    "dashboard"
  end

  def gsidebar(*args)
    cls = self.class.controller_at("/#{args.first}")
    cm = if cls.kind_of?(Array) #or cls == PageController
           "/sidebar"
         else
           "#{cls.mapping}/sidebar"
         end
    redirect cm
  end

  def sidebar
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
