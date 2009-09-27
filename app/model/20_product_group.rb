#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database::Tables

    class ProductGroup < Table(:product_group)

      many_to_one :agency
      one_to_many :products
      many_to_one :jobproducts
      
      Shema = proc{
        DB.create_table :product_group do
          primary_key  :id
          foreign_key  :agency_id
          foreign_key  :job_products_id
          
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
