#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class AddressController < AMSController
  map "/address"
  helper :auth

  before_all { login_required }

  def index
    "add"
  end

  def sidebar
    "add sb"
  end

  def address_for(uid_or_email)
    @id = uid_or_email # needed in template
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
