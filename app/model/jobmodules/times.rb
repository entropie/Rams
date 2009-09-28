#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database
    module Tables

      class JobTime < Table(:jmod_time)

        many_to_one      :job
        
        Shema = proc{
          DB.create_table(:jmod_time) do
            primary_key  :id
            foreign_key  :job_id

            int          :kind, :default => 0
            
            datetime     :end_time
            datetime     :start_time
          end
        }


        def time_type
          case kind
          when 0: :from_to
          when 1: :fixed
          else
            :without
          end
        end
        
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
