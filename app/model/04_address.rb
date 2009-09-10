#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database::Tables

    class Address < Table(:address)

      many_to_one :users

      Shema = proc{
        DB.create_table :address do
          primary_key  :id
          foreign_key  :user_id
          varchar  :name
          varchar  :surename
          varchar  :street
          varchar  :plz
          varchar  :loc

          varchar  :tel_mobile
          varchar  :aemail
          varchar  :tel_priv
          varchar  :fax
        end
      }
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
