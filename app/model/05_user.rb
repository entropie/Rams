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
      one_to_many :todo

      one_to_many :jobs, :class => :Job, :key => :orderer_id
      
      many_to_one :agency
      many_to_one :admin      
      
      Shema = proc{
        DB.create_table :user do
          primary_key :id

          foreign_key :admin_user_id
          foreign_key :agency_id
          
          varchar     :email, :unique => true, :size => 255
          varchar     :passwd, :size => 32
          integer     :parent
        end
      }

      def setup_job(jobhash, modules = [])

        jh = { }.merge(jobhash)
        job = Job.create(jh)
        self.agency.add_job(job)
        self.add_job(job)
        modules.each do |mod|
          mod.update(:job_id => job.id)
        end
        log "Job: uid: #{id}; modules: #{modules.size}; create: #{jh[:name]}"

        job
      end

      
      def is_admin?
        not admin_user_id.nil?
      end
      
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

      def system_user?
        id == 1
      end

      def has_userpic?
        base = public_dir + "avatar.jpg"
        thumb = public_dir + "thumb_avatar.jpg"        
        File.exists?(base) #and File.exists?(thumb)
      end

      def userpic(big = false)
        fname = "/data/user/#{id}/"+"#{big ? "" : "thumb_"}avatar.jpg"
        return "/img/uuser.gif" unless has_userpic?
        fname
      end
      
      def profile_link(str = nil, opts = {})
        o = opts.map{|a,b| "#{a}='#{b}'"}.join(" ")
        "<a #{o} title='#{User[id].email}s Profil' href='/user/profile/#{id}'>#{str || id}</a>"
      end

      def name_link(xhr = true, img = true, w = 14, h = 14)
        add = xhr ? " alink" : ''
        admin_add = is_admin? ? " <img src='/img/mics/star_full.png' width='#{w}' height='#{h}' title='Admin' />" : ""
        ia = "<img src='#{userpic}' width='#{w}' height='#{h}' alt='Benutzerbild' /> %s" % [name]
        "<a class='name_link#{add}' href='/user/profile/%i' title='#{name}'>%s</a>#{admin_add}" % [id, (img ? ia : name)]
      end


      # FIXME: make second argument string: email or userobj
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

