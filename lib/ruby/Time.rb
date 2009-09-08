#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#


class Integer
  def days
    self*86400
  end
end

class Time
  
  def iso_cweek
    thursday = self.beginning_of_week + 3.days
    (thursday.yday - (Time.mktime(thursday.year, 1, 4).beginning_of_week + 3.days).yday)/ 7 + 1
  end

  def beginning_of_week
    days_to_monday = self.wday!=0 ? self.wday-1 : 6
    self - days_to_monday.days
  end
  
  def kw
    strftime("%W")
  end

  def to_datepicker
    strftime("%m/%d/%Y")
  end

  def ykw
    strftime("%Y") + iso_cweek.to_s
  end

  def nts
    strftime("%Y%m%d")
  end

  def de_short
    strftime("%d.%m")
  end

  def t2date
    strftime("%d.%m.%Y")
  end

  def getutc
    Time.utc(self.year, self.month, self.day)
  end

  # returns next day
  def next_day
    d = self + (24*60*60)
    Time.utc(d.year, d.month, d.day)
  end


  # returns a list of days between +self+ and +o+.
  # the block argument is optional.
  def days(o, &blk)
    o = o.next_day
    odate = Time.utc(o.year, o.month, o.day)
    ostart = Time.utc(self.year, self.month, self.day)
    ret, c = [], ostart
    loop{
      ret << c
      c = c.next_day
      break if c == odate
    }
    ret.each(&blk) if block_given?
    ret
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
