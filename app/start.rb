#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require 'rubygems'

ramaze_path = '../../Extern/ramaze/lib/ramaze'
if File.exist?(ramaze_path)
  require ramaze_path
else File.exist?(cappath = '/u/apps/ramaze')
  require cappath + "/lib/ramaze"
end

require File.exists?('../lib/ams') ? '../lib/ams' : 'lib/ams'

module GLog
  def self.<<(str, type = :debug)
    Ramaze::Log.send(type, str)
  end

  def log(str, type = :debug)
    GLog.<<(str, type)
  end
end
extend GLog


controller = %w"ams page css user address messages auth location products todo agency jobs".map{ |lib|
  File.join("controller", lib)
}
#libs = %w"lib".map{|lib| lib }
libs = []

class Innate::Session
  public :cookie
end
(controller + libs).each{|lib| require lib}



Ramaze.start(:host => Rams::PLATFORM == :darwin ? "10.0.187.12" : "graukunst.de",
             :port => Rams::PLATFORM == :darwin ? 8080 : 23000,
             :adapter => :mongrel)


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
