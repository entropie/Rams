#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database::Tables

    class Agency < Table(:agency)

      one_to_many :addresses
      one_to_many :users
      one_to_many :admins, :class => :User, :key => :admin_user_id
      
      Shema = proc{
        DB.create_table :agency do
          primary_key :id

          varchar     :name, :unique => true, :size => 255
        end
      }

      def public_dir
        ud = Rams::Opts[:data_dir] + "/user/#{id}/"
        FileUtils.mkdir_p(ud)
        ud
      end
      
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


      def public_dir
        fname = "public/data/user/#{id}/"
      end
      
      def has_userpic?
        fname = public_dir + "avatar.jpg"
        File.exists?(fname)
      end

      def userpic
        fname = "/data/user/#{id}/"+"avatar.jpg"
        return "/img/uuser.gif" unless has_userpic?
        fname
      end
      
      def profile_link(str = nil, opts = {})
        o = opts.map{|a,b| "#{a}='#{b}'"}.join(" ")
        "<a #{o} title='#{User[id].email}s Profil' href='/user/profile/#{id}'>#{str || id}</a>"
      end

      def name_link(xhr = true, img = true, w = 14, h = 14)
        add = xhr ? " alink" : ''
        ia = "<img src='#{userpic}' width='#{w}' height='#{h}' alt='Benutzerbild' /> %s" % [name]
        "<a class='name_link#{add}' href='/user/profile/%i' title='#{name}'>%s</a>" % [id, (img ? ia : name)]
      end
      
      def send_msg(suser, to, topic, body, reply_to_id = nil)
        to = User.find(:email => to)
        msghash = {:from_id => suser.id, :body => body, :topic => topic}
        msghash.merge!(:in_respond_to => reply_to_id.to_i) if reply_to_id
        to.add_message(Message.create(msghash))
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
