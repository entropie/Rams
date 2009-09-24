#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

usr = User.first

Todos = [
         ["Bilder uploads skallieren", true],
         ["Position der history leiste", false],
         ]

Todos.each {|str, val|
  tdhash = {:category => "DEVEL", :body => str}
  tdhash.merge!(:done => 1) if val
  t = Todo.create(tdhash)
  usr.add_todo(t)
}

         


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
