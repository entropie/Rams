#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

usr = User.first

conts = File.readlines('FIXMES').map{|line|
  case line
  when /^[\s]/
    "<code>%s</code>\n\n" % line.strip
  else
    "<p><mark>#{line}</mark></p>\n\n"
  end
}

Todos = [
         ["Bilder uploads skallieren", true],
         ["Position der history leiste", false],
         ["h3. FixMes\n\n"+conts.to_s, false]
        ]




Todos.each {|str, val|
  tdhash = {:category => "DEVEL", :body => str}
  tdhash.merge!(:done => 1) if val
  t = Todo.create(tdhash)
  usr.add_todo(t)
}

         
puts File.readlines('FIXMES').map{|l| "  #{l}\n"}.to_s

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
