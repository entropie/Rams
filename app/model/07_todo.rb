#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Rams
  module Database::Tables

    class Todo < Table(:todo)
      many_to_one :todo

      Shema = proc{
        DB.create_table :todo do
          primary_key :id
          foreign_key :user_id
          
          datetime    :created_at
          datetime    :modified_at
          varchar     :category, :size => 64
          text        :body
          int         :done, :default => 0
        end
      }
      
      def after_create
        update(:created_at => Time.now)
      end

      def body_markup
        RedCloth.new(body).to_html
      end

      def cat
        if category and not category.strip.size == 0
          "<span id='category' rel='/todo/catedit?mid=#{id};get=1' class='todo_catedit acat'>#{category}</span>"
        else
          "<span id='category' rel='/todo/catedit?mid=#{id};get=1' class='todo_catedit ncat'>(none)</span>"
        end
      end
      
      def icon
        if done == 1
          "<img class='starred' rel='/todo/mark/undone/#{id}' src='/img/starred-small.png' />"
        else
          "<img class='unstarred' rel='/todo/mark/done/#{id}' src='/img/starred-small-g.png' />"
        end
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

