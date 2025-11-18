#!/bin/sh

INPUT="$1"
BASENAME=$(basename "$INPUT" .md)
OUTFILE="/tmp/${BASENAME}.html"
TEMPLATE=$(mktemp)
cat > "$TEMPLATE" << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="refresh" content="1">
  $if(title)$<title>$title$</title>$endif$
  $if(css)$<link rel="stylesheet" href="$css$">$endif$
</head>
<body>
$body$
</body>
</html>
EOF

pandoc "$INPUT" -s --css="$HOME/Notes/style.css" --template="$TEMPLATE" -o "$OUTFILE"
xdg-open "$OUTFILE"
LAST_MTIME=$(stat -c %Y "$INPUT" 2>/dev/null)
while true; do
  sleep 1
  CURRENT_MTIME=$(stat -c %Y "$INPUT" 2>/dev/null)
  if [ "$CURRENT_MTIME" != "$LAST_MTIME" ]; then
    pandoc "$INPUT" -s --css="$HOME/Notes/style.css" --template="$TEMPLATE" -o "$OUTFILE"
    LAST_MTIME=$CURRENT_MTIME
  fi
done

trap "rm -f '$TEMPLATE'" EXIT INT TERM
