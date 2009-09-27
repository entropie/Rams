#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#



1.upto(2) do |ai|
  a = Agency[ai]
  letters = ('A'..'Z').to_a
  pick_letter = proc{ letters.sort_by{rand}.first}
  0.upto(5+rand(20)) do |i|
    
    pgroup = ProductGroup.create(:name => "#{pick_letter.call}roduktruppe Foo #{i}")
    0.upto(20+rand(20)) do |pi|
      product = Product.create(:name => "#{pick_letter.call}rodukt Bar #{pi}")
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
