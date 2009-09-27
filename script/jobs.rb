#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#
jobhash = {:name => "Ein Beispiel-Job", :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}

def gtimes
  mod = (s=rand(10)+1)*3600*24
  {
    :start_time => (a=Time.now)-mod,
    :end_time   => a+mod,
  }
end

puts
puts
puts

u = User.first


mods = []
mtimes = Rams::Database::Tables::job_modules(:times)
mods << mtimes.create(gtimes)

job = u.setup_job(jobhash, mods)

p job.modules

#u.setup_job(jobhash)

puts
puts
puts


#p u.jobs.size
#p Agency.first.jobs.first.orderer
=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
