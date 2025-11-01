registr add shadir "sha256 reproductible directory hash" "shadir <directory>"
function shadir() {
  dirn=$1
  workdir=$(mktemp -d)
  gtar --sort=name \
     --mtime="@0" \
     --owner=0 --group=0 --numeric-owner \
     --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
     -cf $workdir/temp.tar $dirn
  sha256 --quiet $workdir/temp.tar
}