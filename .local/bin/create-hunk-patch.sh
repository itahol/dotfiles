#!/usr/bin/env bash

file="$1"
line="$2"

gawk -v line="$line" '
BEGIN {
  printing_file_header = 0
  printing = 0
  header_count = 0
  in_header_block = 0
}

# When we see diff --git, start recording headers until we see a hunk header (@@).
/^diff --git / {
  in_header_block = 1
  header_count = 0
  printing_file_header = 1
  header_count++
  header[header_count] = $0
  next
}

in_header_block && /^@@/ {
  # We reached the hunk header line, stop header capture before processing it
  in_header_block = 0
  # Do not next here, let the @@ line be processed by the /^@@/ block below
}

in_header_block {
  # Still in the header block, not yet at @@
  header_count++
  header[header_count] = $0
  next
}

/^@@/ {
  printing = 0
  # The regex allows optional ,length parts.
  # If the length is not given, we assume 1 line.
  # Captures:
  # a[1] = old_start
  # a[3] = old_length (optional)
  # a[4] = new_start
  # a[6] = new_length (optional)
  if (match($0, /^@@ -([0-9]+)(,([0-9]+))? \+([0-9]+)(,([0-9]+))? @@/, a)) {
    start_line = a[4] + 0
    if (a[6] != "") {
      hunk_length = a[6] + 0
    } else {
      hunk_length = 1
    }
    end_line = start_line + hunk_length

    if (line >= start_line && line < end_line) {
      if (printing_file_header) {
        for (i = 1; i <= header_count; i++) {
          print header[i]
        }
        printing_file_header = 0
      }
      print $0
      printing = 1
    }
  }
  next
}

printing {
  print $0
}
'

