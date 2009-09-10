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
User.create(
            :email => "foo@bar.com",
            :passwd => User.pwcrypt("test")
)
User.create(
            :email => "bar@foo.com",
            :passwd => User.pwcrypt("test")
)
User.create(
            :email => "foo@baz.com",
            :passwd => User.pwcrypt("test")
)

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
