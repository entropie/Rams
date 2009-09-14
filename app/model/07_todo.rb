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
          varchar     :categorie, :size => 64
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
        if categorie
          "<span id='categorie' rel='/todo/catedit?mid=#{id}' class='inplaceedit acat'>#{categorie}</span>"
        else
          "<span id='categorie' rel='/todo/catedit?mid=#{id}' class='inplaceedit ncat'>none</span>"
        end
      end
      
      def icon
        if done == 1
          "<img class='starred' rel='/starred/mark/undone/#{id}' src='/img/starred-small.png' />"
        else
          "<img class='unstarred' rel='/starred/mark/done/#{id}' src='/img/starred-small-g.png' />"
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

