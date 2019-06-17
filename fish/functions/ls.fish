function ls --description 'List contents of directory'
	set -l param --color=auto
  if isatty 1
    set param $param
  end
  command ls $param $argv
end
