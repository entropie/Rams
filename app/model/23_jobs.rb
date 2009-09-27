#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  class JobModules # < Table(:job_modules)

    @modules = []
    
    def self.create(name, &blk)
      name = "jobmodule_"+name.to_s
      a = Database::Tables.const_set(name.to_s.capitalize, Class.new(Sequel::Model))
      a.instance_variable_set("@simple_table", " " + name.to_s + " ")
      a.one_to_many :jobs
      a.const_set(:Shema, blk)
      @modules << a
      a
    end

    def self.to_a
      @modules
    end
    
  end

  module Database::Tables

    class Job < Table(:job)

      one_to_many :product_groups
      one_to_many :messages
      
      many_to_one :agency
      many_to_one :orderer, :class => User, :key => :orderer_id
      
      Shema = proc{
        DB.create_table :job do
          primary_key :id

          foreign_key :agency_id
          foreign_key :orderer_id

          varchar     :name, :size => 128
          text        :description

          bool        :public, :default => 1
          bool        :finished, :default => 1          

          datetime    :created_at
        end
      }

      def render_module_paths(ext = nil)
        modules.keys.map{|k| "view/modules/jobs/#{k}#{ext.nil? ? '' : "_#{ext}"}.haml"}
      end

      def modules
        Hash[*Rams::Database::Tables::job_modules.map{|mod|
               nname = mod.table_name.to_s.split("_").last
               var = mod.find(:job_id => id)
               [nname.to_sym, var] if var
        }.flatten.compact]
      end
      
      def before_create
        self.created_at = Time.now
      end
      
      def public_dir
        ud = Rams::Opts[:data_dir] + "/#{agency.id}/jobs/#{id}/"
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
