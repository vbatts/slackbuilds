#!/usr/bin/env ruby

autoload :Find, 'find'

module SBo
        SBO_CONFIG_FILE   = "/etc/sbopkg/sbopkg.conf"

        def parse_config(conf_file = SBO_CONFIG_FILE)
                data = Hash.new

		# yaah for escaping new lines
		file_data = File.read(conf_file).gsub("\\\n", " ")

                for line in file_data.split("\n")
                        # cleanup stuffs
                        line = line.split("#")[0]
                        next if line.nil? or line.empty? or line == "\n"
                        line.strip!
                        line = line.gsub(/\"/,'')
                        if line.start_with?("export ")
                                line = line.sub(/export\s*/, "")
                        end

                        key, value = line.split("=",2)
			if value.include?(":-")
                        	data[key] = value.split(":-")[1][0..-2]
			else
                        	data[key] = value.sub(/^"/,"").sub(/"$/,"")
			end
                end
                return data
        end
        module_function :parse_config

	def get_info
		c = parse_config()
		info_files = {}

		dir = File.join(c["REPO_ROOT"], c["REPO_NAME"], c["REPO_BRANCH"])
		Find.find(dir) {|file|
			next if File.directory?(file)
			if file.end_with?(".info")
				info = SBo.parse_config(file)
				info_files[info["PRGNAM"]] = info.dup
				info = nil
			end
		}

		return info_files
	end
        module_function :get_info
end

if __FILE__ == $PROGRAM_NAME

	begin
		SBo.get_info.each {|k,v|
			p k if v["EMAIL"].include?(ENV["USER"])
		}

	ensure
		nil
	end
end
