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
