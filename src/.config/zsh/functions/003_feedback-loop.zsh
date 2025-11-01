registr add feedback-loop "Watch files in a directory and run a command on changes" "feedback-loop ~/projects/myproject 'make build'"
function feedback-loop() {
  fd -I -H -t f . "$1" | entr -s "$2"
}