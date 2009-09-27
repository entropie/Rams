#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database
    module Tables

      class JobProducts < Table(:jmod_products)

        one_to_many      :product_groups
        many_to_one      :job
        
        Shema = proc{
          DB.create_table(:jmod_products) do
            primary_key  :id
            foreign_key  :job_id
          end
        }
      end

      def products
        product_groups.map{|p| p.products}.flatten
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
