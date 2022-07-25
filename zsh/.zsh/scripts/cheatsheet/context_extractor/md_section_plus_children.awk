#!/usr/bin/awk

# Given a line number, return the relevant section in a markdown file. For this
# purpose, sections in a markdown file are determined by the headings. The
# relevant section is the given line's section plus its child sections.

BEGIN {
  current_depth = 0
  buffer = ""
  is_in_desired_section = "false"
  is_in_code_block = "false"
}

# Set flag if we are inside a code block (```)
/^```/ {
  if(is_in_code_block == "false") {
    is_in_code_block = "true"
  } else {
    is_in_code_block = "false"
  }
}

# Match headings, i.e:
# * Lines starting with up to three spaces + at least one # + space
# * That are not inside code blocks
/^[ ]{0,3}#+[ ]/ && is_in_code_block == "false" {
  # Remove leading spaces
  sub(/^[ ]+/, "")
  # Count the number of leading #s
  match($0,/^#+/)
  current_depth = RLENGTH

  # If on the second run and;
  # If we reach a father or sibling of the desired depth, we have to act
  if(FNR != NR && current_depth <= desired_depth) {
    # If we are in the desired section, exit and print
    if(is_in_desired_section == "true") {
      exit
    }
    # If we are not in the desired section yet, reset the buffer
    if(is_in_desired_section == "false") {
      buffer = ""
    }
  }
}

# Write to the buffer
{
  buffer = buffer $0 "\n"
}

# If the current line is the desired line, set the desired depth as the current
# depth
NR==line {
  desired_depth = current_depth
}

# If we are on the second run and the current line is the desired line, we are
# in the desired section
FNR!=NR && FNR==line {
  is_in_desired_section = "true"
}

END {
  print buffer
}
