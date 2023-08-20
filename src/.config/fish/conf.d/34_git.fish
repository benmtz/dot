git config --global --add alias.permission-reset '!git diff -p -R --no-ext-diff --no-color --diff-filter=M | grep -E "^(diff|(old|new) mode)" --color=never | git apply'

