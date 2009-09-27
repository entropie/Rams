#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#


module Rams
  module Database::Tables

    class Location < Table(:location)

      many_to_one :agency
      one_to_many :addresses
      many_to_one :joblocations

      
      Shema = proc{
        DB.create_table :location do
          primary_key  :id

          foreign_key  :agency_id
          foreign_key  :job_location_id
          varchar  :name
        end
      }
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
