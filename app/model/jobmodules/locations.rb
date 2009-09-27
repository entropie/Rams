#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database
    module Tables

      class JobLocation < Table(:jmod_location)

        one_to_many      :locations

        Shema = proc{
          DB.create_table(:jmod_location) do
            primary_key  :id
            foreign_key  :job_id
            bool         :fixed, :default => 0
          end
        }

        
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
