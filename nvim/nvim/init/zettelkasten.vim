" New markdown file with automatic name based on the current date and time
command! -nargs=1 NewTimedMarkdown :execute ":e" <f-args> . "/" . strftime("%y%m%d-%H%M%S") . ".md"

" New logfile at logbook location
command! -nargs=0 NewLog :execute ":e" "~/Projects/pesce.cc/source/logbook/" . strftime("%y%m%d-%H%M%S") . ".md"
