function fish_prompt

	set -l last_status $status
	set -l normal (set_color normal)
	set -l root_color (set_color yellow)
	set -l error_color (set_color magenta)
	set -l job_color (set_color cyan)

	# Just calculate this once, to save a few cycles when displaying the prompt 
	if not set -q uprompt_color
		switch (id -u)
			case 0
				set -g uprompt_color $root_color
			case '*'
				set -g uprompt_color $normal
		end
	end
	

	# Colour first bullet $error_color if previous command errored	
	if [ $last_status -eq 0 ]
		echo -n -s $uprompt_color "•"
	else
		echo -n -s $error_color "•"
	end
	
	# Colour second bullet $job_color if background job running
	if [ (jobs -l | wc -l) -gt 0 ]
		echo -n -s $job_color "•"
	else
		echo -n -s $uprompt_color "•"
	end

	# Final bullet
	echo -n -s $uprompt_color "• " $normal

end
