#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class ProductsController < AMSController
  map "/products"

  def index
    "<p>products</p> " * 100
  end

  def sidebar
    "produts sb"
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
