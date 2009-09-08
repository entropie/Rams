#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class PageController < AMSController
  map     :/

  layout("layout") {|path, wish| !request.xhr? }
  #layout "layout"

  def index
    "asda ddddddddddd"
  end

  def a
    p request.xhr?
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
