#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/ams"

include Rams::Database::Tables


# User
User.create(
            :email => "mictro@gmail.com",
            :passwd => User.pwcrypt("test")
)
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
