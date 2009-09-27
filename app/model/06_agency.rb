#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database::Tables

    class Agency < Table(:agency)

      one_to_many :addresses
      one_to_many :users
      one_to_many :admins, :class => User, :key => :admin_user_id
      one_to_many :product_groups
      one_to_many :jobs
      
      Shema = proc{
        DB.create_table :agency do
          primary_key :id
          varchar     :name, :unique => true, :size => 255
        end
      }

      def public_dir
        ud = Rams::Opts[:data_dir] + "/agency/#{id}/"
        FileUtils.mkdir_p(ud)
        ud
      end

      def logo(w = 128, h = 128)
        file = w > 64 ? "logo.jpg" : "thumb_logo.jpg"
        imgurl =
          if File.exist?(File.join(public_dir, "logo.jpg"))
            "<img class='agencypic' title='#{name}' rel='#{id}' src='/data/agency/#{id}/#{file}' alt='#{name} Logo' width='#{w}' height='#{h}' /> "
          else
            "<img class='noagencypic' rel='#{id}' src='/img/nopic.png' alt='#{name} Logo' width='#{w}' height='#{h}' /> "
          end
      end

      def name_link(img = false)
        img = img ? logo(24, 24) : ''
        "#{img} <a class='agency_name_link alink' href='/agency/#{name.escape(:uri)}' title='#{name}'>#{name}</a> "
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
