#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

u = User[1]

(0..20).map{|i| Faker::Address.city}.each do |loc|
  location = Location.create(:name => loc)
  u.agency.add_location(location)
end

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
