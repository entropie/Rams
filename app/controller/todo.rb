#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class TodoController < AMSController
  map "/todo"

  helper :partial
  
  def index
    @todos = session_user.todo.reverse
  end

  def sidebar
    redirect UserController.r(:sidebar)
  end

  def catedit
    name = request[:name]
    name = request[:nname] if name.size == 0 and request[:nname].size > 0
    mid = request[:mid].to_i
    todo = session_user.todo.find{|t| t.id == mid }
    uhash = {:modified_at => Time.now}
    p uhash.merge!(name.to_sym => request[:value])
    todo.update(uhash)
    request[:value]
  end

  def create
    todo = Todo.create(:body => request[:body])
    session_user.add_todo(todo)
    redirect TodoController.r
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
