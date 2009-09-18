#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams

  Source = File.dirname(File.dirname(File.expand_path(__FILE__)))

  $: << File.join(Source, "lib/ams")

  Version = {
    :major => 0,
    :minor => 1,
    :suffix => "alpha"
  }
  
  # load stdlib exts
  Dir["#{Source}/lib/ruby/*.rb"].each {|file| require file  }

  require "rubygems"
  require "sequel"

  require "redcloth"

  gem 'haml'

  require 'sass'  
  
  require "contrib"
  require "database"
  require "logger"
  require "pp"

  Opts = {}
  Opts[:public_dir] = pd="public"
  Opts[:data_dir]   = "#{pd}/data"
  
  DB = Sequel.mysql('rams_devel',
                    :user => 'root',
                    :password => '',
                    :logger => Logger.new( STDOUT ),
                    :host => "localhost",
                    :socket => "/tmp/mysql.sock")
  def self.version
    str = "Ramp-%i.%i" % [Version[:major], Version[:minor]]
    str << "-#{Version[:suffix]}" if Version[:suffix]
  end
  
end


def log(str)
  puts "> %s" % str
end

Rams::Database.load_definitions

puts "%s starts up" % Rams.version if __FILE__ == $0


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
