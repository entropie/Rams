#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module DBHelper

    module DefaultHelper
    end
    
    def self.helper(help = nil)
      consts = self.constants.map{ |c| DBHelper.const_get(c)}
      ret =
        if help
          consts.select{ |c| c.to_s.downcase =~ /#{help.to_s.downcase}helper/ }.first
        else
          consts
        end
      return DBHelper::DefaultHelper if ret.nil?
      ret
    end

    def self.select_for(sequel_kls)
      helper(sequel_kls.to_s.split('::').last)
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
