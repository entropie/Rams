#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams

  Version = {
    :major => 0,
    :minor => 1,
    :suffix => "alpha"
  }

  def self.version
    str = "Ramp-%i.%i" % [Version[:major], Version[:minor]]
    str << "-#{Version[:suffix]}" if Version[:suffix]
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
