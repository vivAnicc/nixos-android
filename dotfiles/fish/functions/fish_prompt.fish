set -l last_status $status

set -l stat
if test $last_status -ne 0
    set -l msg (fish_status_to_signal $last_status)
    if test $msg = 127
	set msg NOTFOUND
    end
    set stat (set_color -o brred)"[$msg]"(set_color normal)
end

string join '' -- (set_color -o 87FF00) (whoami) (set_color -o C3CBE9) ':' \
    (set_color -o AFFFFF) (prompt_pwd --full-length-dirs 2) (set_color C3CBE9) \
    '$' $stat (set_color normal) ' '
