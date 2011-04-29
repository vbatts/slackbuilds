#!/usr/bin/env ruby
#
# Fri Jan 28 17:19:49 EST 2011
# vbatts@hashbangbash.com
#
# pointless script ...
#

require 'yaml'

LIST = File.join(Dir.pwd, "todo.list")

def load_list()
        if File.exist?(LIST)
	        @todos = YAML::load(File.read(LIST))
	        printf("%d TODOs loaded from %s\n", @todos.count, LIST)
        else
                @todos = []
	        printf("Starting a new TODOs list (don't forget to save)\n", @todos.count, LIST)
        end
end

def pretty_print(change)
        if change[:new].empty?
	        return sprintf("PKG: %s, ACTION: %s,",  change[:pkg], change[:old])
        else
	        return sprintf("PKG: %s, FROM: %s, TO: %s",  change[:pkg], change[:old], change[:new])
        end
end

def show_list()
	@todos.each {|change|
		printf("%s\n",  pretty_print(change))
	}
end

def delete()
	puts "which would you delete?"
	@todos.each {|change|
		printf("[%d] %s\n", @todos.index(change), pretty_print(change))
	}
	printf("$> ")
	resp = gets.chomp.to_i
	t_count = @todos.count
	case resp
	when 0..t_count
		puts "  You want to delete #{@todos[resp][:pkg]} from the list ? (yes/No)"
		printf("$> ")
		resp1 = gets.chomp
		if resp1 =~ /^y(es)?$/i
			d = @todos.delete_at(resp)
			puts "  Deleted #{pretty_print(d)}\n"
			@updated = true
		else
			puts "  nothing done\n"
		end
	else
		puts "ERROR: #{resp} is not a valid position"
	end
end

def add()
	puts "Package name to add?"
	printf("$> ")
	resp1 = gets.chomp
	puts "action needed? or old version?"
	printf("$> ")
	resp2 = gets.chomp
	puts "new version?"
	printf("$> ")
	resp3 = gets.chomp
	this_add = {:pkg => resp1, :old => resp2, :new => resp3}
	@todos << this_add
	puts "Added #{pretty_print(this_add)}\n"
	@updated = true
end

def has_changes?()
	return @updated
end

def save_list()
	f = File.open(LIST, "w+")
	f << @todos.to_yaml
	f.close
	printf("%d TODOs saved to %s\n", @todos.count, LIST)
	@updated = false
end

def ask_them()
	while true
		puts "What would you like to see?"
		puts "  (L)ist, (A)dd, (D)elete, (S)ave, (R)eload, (Q)uit"
		printf("$> ")
                begin
		        resp = gets.chomp
                rescue
                        printf("\n")
                        exit 0
                end
		case resp
			when /^l$/i
				show_list
			when /^s$/i
				save_list
			when /^a$/i
				add
			when /^r$/i
				load_list
			when /^d$/i
				delete
			when /^q$/i
				if has_changes?()
					puts "WARNING: there are unsaved changes, do you really want to exit?"
					resp2 = gets.chomp
					if resp2 =~ /^y(es)?$/
						puts "WARNING: nothing saved"
						exit 0
					else
						puts "returning"
					end

				else
					exit 0
				end
			else
				puts "i've got nothing on that! (#{resp})"
		end
	end
end

def main()
	load_list()
	ask_them()
end

if __FILE__ == $PROGRAM_NAME
        if ARGV.include?("-h") || ARGV.include?("--help")
	        puts " use -l / --list to show the list, otherwise use the menu"
        elsif ARGV.include?("-l") || ARGV.include?("--list")
	        load_list
	        show_list
        else
	        main()
        end
end
