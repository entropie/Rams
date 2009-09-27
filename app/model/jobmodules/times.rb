#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database
    module Tables

      class Times < Table(:jmod_times)
        
        Shema = proc{
          DB.create_table(:jmod_times) do
            primary_key  :id
            foreign_key  :job_id
            datetime      :start_time
            datetime      :end_time
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
