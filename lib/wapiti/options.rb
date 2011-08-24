module Wapiti
		
	class Options
		
		include Comparable
		
		class << self
				
			def attribute_names
				@attribute_names ||= %w{ mode stop_window convergence_window
					max_iterations jobsize threads rho1 rho2 stop_epsilon input output
					algorithm pattern development_data maxent compact sparse label check
					posterior score }.sort.map(&:to_sym).freeze
			end
			
			def defaults
				@defaults ||= new.attributes
			end
			
		end
		
		# Returns the value of the attribute identified by +name+ or nil
		# if there is no such attribute.
		def [](name)
			has_attribute?(name) ? nil : send(name)
		end
		
		# Updates the value of the attribute identified by +name+ with the
		# passed-in +value+.
		def []=(name, value)
			raise ArgumentError, "bad attribute name: #{name}" unless has_attribute?(name)
			send("#{name}=", value)
		end
		
		# Updates all the attributes from the passed-in hash.
		def update(attributes = {})
			attributes.each_pair do |k,v|
				mid = "#{k}="
				send(mid, v) if respond_to?(mid)
			end	
			self
		end
		
		alias update_attributes update
		
		# Returns a hash of all the attributes with their names and values.
		def attributes
			Hash[*Options.attribute_names.map { |a| [a, send(a)] }.flatten]
		end
		
		alias to_hash attributes
		
		def has_attribute?(attribute)
			Options.attributes.include?(attribute)
		end
		
		def <=>(other)
			other.respond_to?(:attributes) ? attributes <=> other.attributes : nil
		end
		
	end
	
end