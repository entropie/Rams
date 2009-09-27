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

            datetime     :end_time
            datetime     :start_time
          end
        }


        def fixed_duration?
          not end_time.nil? and not start_time.nil?
        end

        def inifinte?
          not start_time.nil? and end_time.nil?
        end
        
        def everywhere?
          end_time.nil? and start_time.nil?
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
