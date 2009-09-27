#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class JobController < AMSController
  map "/jobs"
  helper :auth

  before_all { login_required }

  def index(jobid = nil)
    @jobs = session_user.agency.jobs
    if jobid
      jid = jobid.to_i
      @job = @jobs.select{|j| j.id == jid}.first
      @target_id = @job.id
    end
  end

  def create(kind = "job")
    case kind
    when "skel"
      call r(:mk_skel)
    end
  end
  
  def sidebar(*args)
    @job =
      if args.size == 2
        Job[args.last.to_i]
      end
  end

  def mk_skel
  end

  def step1
    @form_data = request[:ja]
    @mods = request[:mods]
    @name = @form_data["name"]
    @description = @form_data["description"]
  end

  def step2
    p request.params
    "step2"
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
