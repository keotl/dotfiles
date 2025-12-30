function dotenv
  set -l file $argv[1]
  if test -z "$file"
    set file ".env"
  end
  
  for line in (cat $file | grep -v '^#' | grep -v '^$')
    set item (string split -m 1 '=' $line)
    set -gx $item[1] $item[2]
    echo "Exported key $item[1]"
  end
end

