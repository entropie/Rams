#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "digest/md5"

module Rams
  module Database::Tables

    class User < Table(:user)

      one_to_many :addresses
      
      Shema = proc{
        DB.create_table :user do
          primary_key :id
          varchar     :email, :unique => true, :size => 255
          varchar     :passwd, :size => 32
          integer     :parent
        end
      }

      def addresses
        [Address[:user_id => id]]
      end
      
      def self.pwcrypt(pw)
        Digest::MD5.
          hexdigest(pw||
                    (('a'..'z').to_a + ('A'..'Z').to_a).flatten.
                    sort_by{ rand }.last(8).join
                    )
      end

      def profile_link(str = nil, opts = {})
        o = opts.map{|a,b| "#{a}='#{b}'"}.join(" ")
        "<a #{o} title='#{User[id].email}s Profil' href='/user/profile/#{id}'>#{str || id}</a>"
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

