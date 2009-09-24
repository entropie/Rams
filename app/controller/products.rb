#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class ProductsController < AMSController
  map "/products"
  helper :auth

  before_all { login_required }

  def index(*args)
    @product_groups = session_user.agency.product_groups
    if args.size == 2
      if args.first == "productgroup"
        @target_id = args.last.to_i
        @pgroup = ProductGroup[@target_id]
        @products = @product_groups.map{|pg| pg.id == @target_id ? pg : nil }.
          compact.map{|pg| pg.products}.flatten
      elsif args.first == "product"
        call(r(:product, args.last.to_i))
      end
    end
  end

  def product(id)
    id = id.to_i
    @product = Product[id]
    @pgroup = @product.product_group
  end
  
  def sidebar(*args)
    @pgroup =
      if args.size == 3
        ProductGroup[args.last.to_i]
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
