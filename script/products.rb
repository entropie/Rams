#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#



1.upto(2) do |ai|
  a = Agency[ai]
  letters = ('A'..'Z').to_a
  pick_letter = proc{ Faker::Lorem.words(1+rand(3)+rand(3)).join(" ") }
  0.upto(5+rand(20)) do |i|
    
    pgroup = ProductGroup.create(:name => pick_letter.call)
    0.upto(20+rand(20)) do |pi|
      product = Product.create(:name => pick_letter.call)
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
