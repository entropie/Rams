#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/ams"

require "faker"


include Rams::Database::Tables


agency = Agency.create(:name => "Ackro Inc")
agency1 = Agency.create(:name => "FooFirma")


letters = "abcdefghijklmnopqrstuvwxyz".scan(/./)

0.upto(100){|i| Agency.create(:name => "#{letters.sort_by{rand}.first.capitalize}est Agentur #{i}")}

# User
a=User.create(
              :email => "mictro@gmail.com",
              :passwd => User.pwcrypt("test")
              )
a.agency = agency
a.save
agency.add_admin(a)
agency.save

a.add_address(Address.create(
                             :name => "Michael",
                             :surename => "Ende",
                             :street   => "Nightmare On Elm Street",
                             :plz      => "00666",
                             :loc      => "Hell",
                             :tel_mobile => "0666 666 666",
                             :tel_priv   => "0666 1"
                             ))
a.send_msg(User.first, "mictro@gmail.com", "Betreff Bla", "Body Bla")


a=User.create(
              :email => "foo@bar.com",
              :passwd => User.pwcrypt("test")
              )
a.add_address(Address.create(
                             :name => "Bort1",
                             :surename => "End",
                             :street   => "Nightmare On Elm Street",
                             :plz      => "00666",
                             :loc      => "Hell",
                             :tel_mobile => "0666 123 431",
                             :tel_priv   => "0666 1"
                             ))
a.agency = agency
a.save


a=User.create(
              :email => "bar@foo.com",
              :passwd => User.pwcrypt("test")
              )
a.add_address(Address.create(
                             :name => "Bart",
                             :surename => "End",
                             :street   => "Nightmare On Elm Street",
                             :plz      => "00666",
                             :loc      => "Hell",
                             :tel_mobile => "0666",
                             :tel_priv   => "0666 1"
                             ))

a.agency = agency
a.save

0.upto(64) do |i|

  a=User.create(
                :email => Faker::Internet.email,
                :passwd => User.pwcrypt("test")
                )
  a.add_address(Address.create(
                               :name => Faker::Name.name,
                               :surename => Faker::Name.last_name,
                               :street   => Faker::Address.street_address,
                               :plz      => Faker::Address.zip_code,
                               :loc      => Faker::Address.city,
                               :tel_mobile => Faker::PhoneNumber.phone_number,
                               :tel_priv   => Faker::PhoneNumber.phone_number
                               ))
  a.agency = (i % 2 == 0) ? agency : agency1
  a.save
  
end


require "script/todo"
require "script/products"
require "script/locations"
require "script/jobs" 

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
