#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database::Tables

    class Messages < Table(:messages)
      many_to_one :users

      Shema = proc{
        DB.create_table :user do
          primary_key :id
          foreign_key :user_id
          varchar     :created_at
          varchar     :topic, :size => 255
          text        :body
          int         :in_respond_to
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
