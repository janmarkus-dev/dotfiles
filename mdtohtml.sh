#!/bin/sh

OUT="/tmp/$(basename "$1" .md).html"
TMP=$(mktemp)

cat > "$TMP" << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="refresh" content="1">
  $if(title)$<title>$title$</title>$endif$
  $if(css)$<link rel="stylesheet" href="$css$">$endif$
</head>
<body>
$body$
</body>
</html>
EOF

pandoc "$1" -s --css="$HOME/Notes/style.css" --template="$TMP" -o "$OUT"
xdg-open "$OUT"
inotifywait -m -e modify,close_write "$1" | while read -r; do
  pandoc "$1" -s --css="$HOME/Notes/style.css" --template="$TMP" -o "$OUT"
done
trap "rm -f '$TMP'" EXIT INT TERM
