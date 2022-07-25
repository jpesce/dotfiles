" New logfile at logbook location
command! -nargs=0 NewLog :execute ":e" "~/Projects/pesce.cc/source/logbook/" . strftime("%y%m%d-%H%M%S") . ".md"
