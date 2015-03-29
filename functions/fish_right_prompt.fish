function fish_right_prompt -d "Prints right prompt"

	set	-l normal (set_color normal)
	set	-l pwd_color (set_color green)
	set	-l dirty_git_color (set_color red)
	set	-l clean_git_color (set_color cyan)

	# Print git status
	if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
	  set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)
	  set -l ref (command git symbolic-ref HEAD | sed  "s-refs/heads/--" | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)

	  if [ "$dirty" != "0" ]
	    echo -n -s $dirty_git_color $ref '*' $dirty ' '
	  else
	  	echo -n -s $clean_git_color $ref ' '
	  end
	end

  echo -n -s $pwd_color (pwd) $normal
end