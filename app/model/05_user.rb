#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "digest/md5"

module Rams
  module Database::Tables

    class User < Table(:user)

      # many_to_one :user_state
      # many_to_one :address
      # many_to_one :privilege
      # many_to_one :user_role
      

      set_schema do
        primary_key :id

        varchar  :email, :unique => true, :size => 255
        varchar  :passwd, :size => 32
        integer  :parent
      end

      def self.pwcrypt(pw)
        Digest::MD5.
          hexdigest(pw||
                    (('a'..'z').to_a + ('A'..'Z').to_a).flatten.
                    sort_by{ rand }.last(8).join
                    )
      end

      def profile_link(str = nil)
        "<a href='/user/profile/#{id}'>#{str || id}</a>"
      end
      
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

