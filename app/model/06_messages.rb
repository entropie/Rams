#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database::Tables

    class Message < Table(:messages)
      many_to_one :users

      Shema = proc{
        DB.create_table :messages do
          primary_key :id
          foreign_key :user_id
          foreign_key :from_id
          
          datetime    :created_at
          varchar     :topic, :size => 255
          text        :body
          int         :in_respond_to
          int         :read, :default => 0
        end
      }

      def from
        User[from_id]
      end
      def to
        User[user_id]
      end

      def reply_topic
        "Re: %s" % topic
      end
      
      def after_create
        update(:created_at => Time.now)
      end

      def body_markup
        RedCloth.new(body).to_html
      end

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
