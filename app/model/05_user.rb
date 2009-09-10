#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "digest/md5"

module Rams
  module Database::Tables

    class User < Table(:user)

      one_to_many :addresses
      one_to_many :messages      
      
      Shema = proc{
        DB.create_table :user do
          primary_key :id
          varchar     :email, :unique => true, :size => 255
          varchar     :passwd, :size => 32
          integer     :parent
        end
      }

      def name
        if addresses.empty?
          email
        else
          adr = addresses.first
          "%s %s" % [adr.name, adr.surename] rescue email
        end
      end
      
      def addresses
        [Address[:user_id => id]]
      end

      def pw1; passwd; end
      def pw2; passwd end
      
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

      def name_link(xhr = true)
        add = xhr ? " alink" : ''
        ia = "<img src='/img/uuser.gif' width='12' height='12' alt='Benutzerbild' />%s" % [name]
        "<a class='name_link#{add}' href='/user/profile/%i' title='#{name}'>%s</a>" % [id, ia]
      end
      
      def send_msg(to, topic, body)
        to = User.find(:email => to)
        p topic
        to.add_message(Message.create(:from_id => id, :body => body, :topic => topic))
        to.save
        "k"
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

