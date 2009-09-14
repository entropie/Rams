#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/ams"

include Rams::Database::Tables


# User
a=User.create(
              :email => "mictro@gmail.com",
              :passwd => User.pwcrypt("test")
              )
a.add_address(Address.create(
                             :name => "Michael",
                             :surename => "Ende",
                             :street   => "Nightmare On Elm Street",
                             :plz      => "00666",
                             :loc      => "Hell",
                             :tel_mobile => "0666",
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
                             :tel_mobile => "0666",
                             :tel_priv   => "0666 1"
                             ))

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


0.upto(10) do |i|

  a=User.create(
                :email => "foo#{i}@baz.com",
                :passwd => User.pwcrypt("test")
                )
  a.add_address(Address.create(
                               :name => "Bum the #{i}",
                               :surename => "End",
                               :street   => "Nightmare On Elm Street",
                               :plz      => "00666",
                               :loc      => "Hell",
                               :tel_mobile => "0666",
                               :tel_priv   => "0666 #{i*100}"
                               ))
end

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
