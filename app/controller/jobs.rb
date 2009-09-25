#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class JobController < AMSController
  map "/jobs"
  helper :auth

  before_all { login_required }

  def index
    "jobs"
  end

  def create(kind = "job")
    case kind
    when "skel"
      call r(:mk_skel)
    end
  end
  
  def sidebar(*args)
    "add sb"
  end

  def mk_skel
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
