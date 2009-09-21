#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class AgencyController < AMSController
  map "/agency"
  helper :auth

  before_all { login_required }

  def index
    "add"
  end

  def sidebar
    "add sb"
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
