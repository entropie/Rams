#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class UserController < AMSController
  map "/user"

  def index
    "user"
  end

  def sidebar
    p 1
    "user sb"
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
