#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class LocationController < AMSController
  map "/location"
  helper :auth

  before_all { login_required }

  def index
    "location"
  end

  def sidebar(*args)
    "location sb"
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
