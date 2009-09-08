#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams

  module Database

    LoadedDefintions = []
    module Tables

      def self.Table(*a)
        ret = ::Sequel::Model(a.first)
        #ret.extend(TableExt)
        ret
      end

    end

    def self.migrate(w = :up)
      definitions.each do |defi|
        if defi.table_exists? and w == :down
          defi.drop_table
        elsif w == :up
          begin
            defi.create_table
            p defi
          rescue
            p $!
          end
        end
      end
    end

    def self.database(db = :sequel)
      self.class.const_get(db.to_s.downcase.capitalize)
    end

    def self.definitions
      load_definitions
      consts = Database::Tables.constants.map{ |const|
        const = Database::Tables.const_get(const)
      }
      consts.map do |constcls|
        constcls.class_eval {
          include DBHelper.select_for(constcls)
        }
      end
    end
    
    def self.load_definitions(force = false)
      LoadedDefintions.clear if force
      return nil unless LoadedDefintions.empty?
      Dir["#{Rams::Source.to_s}/app/model/*.rb"].sort.each do |l|
        log "model load: #{File.basename(l)}"
        LoadedDefintions << l
        require l
      end
    end

    def self.model(db = :sequel)
      self.database.model
    end

    class Adapter
      def model
        @model ||= :sequel
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
