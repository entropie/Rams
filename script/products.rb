#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#



1.upto(10) do |ai|
  a = Agency[ai]
   0.upto(20) do |i|
    pgroup = ProductGroup.create(:name => "Produktruppe Foo #{i}")
    0.upto(20) do |pi|
      product = Product.create(:name => "Produkt Bar #{pi}")
      pgroup.add_product(product)
    end
    pgroup.save
    a.add_product_group(pgroup)
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
#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#



=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
