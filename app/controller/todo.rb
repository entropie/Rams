#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class TodoController < AMSController
  map "/todo"

  helper :partial
  helper :auth

  before_all { login_required }
  
  def index(what = :category, which = nil, starred = nil)
    @todos = session_user.todo.reverse
    @which = which
    if @which
      @todos.reject!{|t| t.category != @which} 
    end
    @starred =
      if starred or (what and what == 'starred')
        @todos.reject!{|t| not t.starred? }
        true
      else
        @todos.reject!{|t| t.starred? }
        false
      end
  end

  def todo(id)
    @todo = session_user.todo.find{|t| t.od == id}
  end

  def sidebar(*args)
    @rp = request.env["REQUEST_PATH"].sub("/sidebar", '')
    @todos =  session_user.todo.reverse
    @cats = @todos.map{|t| t.category || "" }.uniq.sort.select{|t| t.size > 0}
    if args.size == 1 and starred = args.first
      @starred = true
    else
      @starred = false
    end
    if args.size >= 3
      what = if args.size == 3 then args.last else @starred = true; args[-2]; end
      @cat = @cats.select{|c| c == what}.join
    end
  end
  

  def catedit
    name = request[:name]
    name = request[:nname] if name and name.size == 0 and request[:nname].size > 0
    mid = request[:mid].to_i
    todo = session_user.todo.find{|t| t.id == mid }
    if request[:get] == "1"
      @categories = Todo.all.map{|t| t.category}.compact.uniq
      @todo = todo
    else
      if request[:wo_markup] == "1"
        @value = todo.body
      else
        uhash = {:modified_at => Time.now}
        uhash.merge!(name.to_sym => request[:value])
        todo.update(uhash)
        if name.to_sym == :category
          @todo = todo
        else
          @value = todo.body_markup
        end
      end
    end
  end
  

  def mark(what, id)
    id = id.to_i
    @todo = Todo[id]
    case what
    when "undone"
      @todo.update(:done => 0)
    when "done"
      @todo.update(:done => 1)      
    end
    @todo.icon
  end

  
  def create
    phash = {:body => request[:body]}
    cat = request[:category]
    if cat
      phash.merge!(:category => cat)
    end
    todo = Todo.create(phash)
    session_user.add_todo(todo)
    r = if cat
          TodoController.r(:index, :category, cat)
        else
          TodoController.r
        end
    redirect r
  end


  def delete(id)
    todo = Todo[id.to_i]
    if todo
      session_user.remove_todo(todo)
    end
    "Gelöscht"
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
