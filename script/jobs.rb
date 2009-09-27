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

location = u.agency.locations.first

mods = []

mtimes = Rams::Database::Tables::job_modules(:time)
mods << mtimes.create(gtimes)

mlocs =  Rams::Database::Tables::job_modules(:location)
mlocs = mlocs.create(:fixed => 1)
mlocs.add_location(location)
mods << mlocs

mpgs =  Rams::Database::Tables::job_modules(:products)
mpgs = mpgs.create
pg = u.agency.product_groups.first
mpgs.add_product_group(pg)
mods << mpgs

job = u.setup_job(jobhash, mods)
# pp job
pp job.modules[:products].job
# puts
#pp job.modules[:location].job

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
