#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#


module Rams
  module Database::Tables

    class Product < Table(:product)

      one_to_many :product_groups

      Shema = proc{
        DB.create_table :product do
          primary_key  :id
          foreign_key  :product_group_id
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
