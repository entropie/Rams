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
      @agency = agency_from_argument(agency_string_or_id)
    else
      call(r(:list))
    end
    
  end

  def upload(uid)
    tempfile = request.params["userfile"][:tempfile]
    name = request.params["userfile"][:filename]    
    @agency = Agency[uid.to_i]
    FileUtils.mkdir_p(@agency.public_dir)
    FileUtils.copy(tempfile.path, file = @agency.public_dir+"logo.jpg")
    Thumbnail(file, 48)
  end

  def list
    @agencies = {}
    @all_agencies = Agency.all
    @all_agencies.map{|a|
      @agencies[ a.name[0..0] ] ||= []
      @agencies[ a.name[0..0] ] << a
    }
  end

  def sidebar(*args)
    @agency = agency_from_argument(args.first)
  end

  private

  def agency_from_argument(arg)
    if arg.scan(/[0-9]/).size == arg.size
      Agency[arg.to_i]
    elsif arg.scan(/[A-Za-z0-9 ]/).size == arg.size
      Agency[:name => arg ]      
    else
    end
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
