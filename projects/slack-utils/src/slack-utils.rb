#!/usr/bin/env ruby 
# started - Fri Oct  9 15:48:43 CDT 2009
# updated for args - Tue Mar 23 14:54:19 CDT 2010
# Copyright 2009, 2010 Vincent Batts, http://hashbangbash.com/

# Variables
@pd = '/var/log/packages'
@pa = Dir.entries(@pd)
@me = File.basename($0)
@st = "\033[7m"
@en = "\033[m"

# Functions
def slp
  if ARGV.count == 0
    @pa.each {|pkg|
      puts pkg
    }
  else
    ARGV.each {|arg|
      puts @pa.grep(/#{arg}/)
    }
  end
end

def slt
  if ARGV.count == 0
    @pa.each {|pkg|
      p = File.absolute_path File.join(@pd, '/', pkg)
      f = File.open(p)
      ft = f.mtime
      puts "#{pkg}:\s#{ft}"
    }
  else
    ARGV.each {|arg|
      @pa.grep(/#{arg}/).each {|pkg|
        p = File.absolute_path File.join(@pd, '/', pkg)
        f = File.open(p)
        ft = f.mtime
        puts "#{pkg}:\s#{ft}"
      }
    }
  end
end

def slf
  if ARGV.count == 0
    puts "#{@me}: what file do you want me to search for?"
  else
    ARGV.each {|arg|
      r = Regexp::new /#{arg}/
      @pa.each {|pkg|
        p = File.absolute_path File.join(@pd, '/', pkg)
        if p == @pd || p == "/var/log"
            next
        end
        f = File.open(p)
        f.each {|line|
          o = line.gsub! r, "#{@st}\\&#{@en}"
          puts pkg + ":\s" + o if ! o.nil?
        }
      }
    }
  end
end


# Main

# Do package related functions if called as slp
slp if @me == "slp"

# Do file related functions if called as slf
slf if @me == "slf"

# Do file related functions if called as slf
slt if @me == "slt"

