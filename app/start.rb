#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require 'rubygems'


require '../../Extern/ramaze/lib/ramaze'

gem 'sequel', "2.6.0"
gem 'haml'
require 'sass'

module GLog
  def self.<<(str, type = :debug)
    Ramaze::Log.send(type, str)
  end

  def log(str, type = :debug)
    GLog.<<(str, type)
  end
end
extend GLog


controller = %w"page".map{ |lib|
  File.join("controller", lib)
}


# require 'controller/css'
# require 'controller/paste'
# require 'controller/spam'
# require 'controller/account'
 
# class Highlight
#   def default_options
#     { :engine => $rapaste[:engine],
#       :fragment => $rapaste[:fragment] }
#   end
 
#   mod = EXTEND[$rapaste[:engine]]
#   mod.setup(__DIR__)
#   $rapaste_syntaxes = mod.syntaxes($rapaste[:priority])
# end
 
# # The Bayes database contains information about the ham and spam rating of
# # certain words.
# # If you would like to reset it, just remove the db/bayes.marshal file.
# BAYES = Bayes.new( File.join( __DIR__, 'db/bayes.marshal' ) )
 
# # Initial seeding of the bayes filter, setting up categories and a couple of
# # common ratings.
# # The format of the files isn't that important, given that it should recognize
# # any text.
# # But you should separate words in some way (whitespace, commas, numbers...)
# if BAYES.categories.empty?
#   BAYES.train(:spam, File.read( File.join( __DIR__, 'db/spam.txt' ) ))
#   BAYES.train(:ham, File.read( File.join( __DIR__, 'db/ham.txt' ) ))
# end
 
# Ramaze.start($rapaste[:ramaze]) if $0 == __FILE__


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
