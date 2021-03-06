#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#


# FIXME: Write pid somewhere to get ams gracefully killed by remote
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
  
  require "RMagick"
  
  require "contrib"
  require "database"
  require "logger"
  require "pp"

  Opts = {}
  Opts[:public_dir] = pd="public"
  Opts[:data_dir]   = "#{pd}/data"


  DBHash =
    if `uname` =~ /Darwin/ then
      PLATFORM = :darwin
      {
      :socket => "/tmp/mysql.sock",
      :host   => "localhost",
      #:logger => Logger.new( STDOUT ),
      :user   => "root",
      :password => ''
    } else
      PLATFORM = :nix
      {
      :socket => "/var/run/mysqld/mysqld.sock",
      :host   => "graukunst.de",
      :user   => "ams",
      :password => File.readlines(File.join(Source, ".mysql.pw")).join.strip
    } end
  DB = Sequel.mysql('rams_devel', DBHash)

  def self.version
    str = "Ramp-%i.%i" % [Version[:major], Version[:minor]]
    str << "-#{Version[:suffix]}" if Version[:suffix]
  end

end


def log(str)
  puts "> %s" % str
end

Rams::Database.load_definitions
Rams::Database.load_definitions(false, "jobmodules/")

puts "%s starts up" % Rams.version if __FILE__ == $0


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
