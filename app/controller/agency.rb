#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class AgencyController < AMSController
  map "/agency"
  helper :auth

  before_all { login_required }

  def index(agency_string_or_id = nil)
    if agency_string_or_id
      @agency =
        if agency_string_or_id.scan(/[A-Za-z ]/).size == agency_string_or_id.size
          Agency[:name => agency_string_or_id ]
        elsif agency_string_or_id.scan(/[0-9]/).size == agency_string_or_id.size
          Agency[agency_string_or_id.to_i]
        else
        end
    end
    p @agency
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
