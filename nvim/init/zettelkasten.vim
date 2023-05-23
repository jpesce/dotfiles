" New logfile at logbook location
command! -nargs=0 NewLog :execute ":e" "~/Projects/shite/source/logs/" . strftime("%y%m%d%H%M%S") . ".md"
