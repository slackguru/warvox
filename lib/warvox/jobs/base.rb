module WarVOX
module Jobs
class Base
	attr_accessor :name, :status
	
	def type
		'base'
	end
	
	def stop
		@status = 'active'
	end
	
	def start
		@status = 'completed'
	end
	
	def db_save(obj)
		max_tries = 100
		cur_tries = 0
		begin
			obj.save
		rescue ::SQLite3::BusyException => e
			cur_tries += 1
			if(cur_tries > max_tries)
				$stderr.puts "ERROR: Database is still locked after #{cur_tries} attempts"
				raise e
				return
			end
			Kernel.select(nil, nil, nil, rand(10) * 0.25  )
			retry
		end	
	end
	
	def clear_zombies
		begin
			# Clear zombies just in case...
			while(Process.waitpid(-1, Process::WNOHANG))
			end			
		rescue ::Exception
		end
	end
end
end
end

