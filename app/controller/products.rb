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
    if args.size == 2 and args.first == "productgroup"
      @target_id = args.last.to_i
      @pgroup = ProductGroup[@target_id]
      @products = @product_groups.map{|pg| pg.id == @target_id ? pg : nil }.
        compact.map{|pg| pg.products}.flatten
    end
  end

  def sidebar(*args)
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
