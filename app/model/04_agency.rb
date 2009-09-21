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
        ud = Rams::Opts[:data_dir] + "/agency/#{id}/"
        FileUtils.mkdir_p(ud)
        ud
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
