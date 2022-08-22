#!/bin/sh
set -ue

# Help: creates a git repo out of /etc and adds all its content to the repo.
# Could be useful for configuration management

DST=/etc

cd "$DST"

if git status -s 2>/dev/null ;
then
    echo "Nothing to do: $DST is already a git repo."
    exit 1
fi

cat > "$DST/.gitignore" <<'EOT'
*.gz
*.db
*.cache
*.lock
*~
EOT

git init

git add .

git ci -m "Initial commit: turn $DST in a git repo"

chmod -R 0700 .git
