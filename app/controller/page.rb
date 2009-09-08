#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class PageController < AMSController
  map     :/

  layout("layout") {|path, wish| !request.xhr? }
  #layout "layout"

  def index
    "asd"
  end

  def a
    p request.xhr?
    "a"
  end

  def b
    p request.xhr?
    "b"
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
