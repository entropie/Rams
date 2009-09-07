#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class PageController < AMSController
  map     :/

  layout  "/layout"

  def index
    logged_in?.to_s
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
