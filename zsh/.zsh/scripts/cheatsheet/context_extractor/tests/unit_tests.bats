#!/usr/bin/env bats

setup() {
  # Add script to the $PATH
  PATH="${BATS_TEST_DIRNAME}/../:${PATH}"
}

@test "level one heading prints the heading" {
  echo "# Heading" > "${BATS_TEST_TMPDIR}/input"
  run context_extractor.sh "${BATS_TEST_TMPDIR}/input" 1

  echo "output = ${output}"
  [ "$output" = "# Heading" ]
}

@test "level one heading plus level two heading prints both headings" {
  echo -e "# Heading one\n\n## Heading two" > "${BATS_TEST_TMPDIR}/input"
  run context_extractor.sh "${BATS_TEST_TMPDIR}/input" 1

  echo "output = ${output}"
  [ "$output" = $'# Heading one\n\n## Heading two' ]
}

@test "level two heading plus level one heading prints level two heading" {
  echo -e "## Heading two\n\n# Heading one" > "${BATS_TEST_TMPDIR}/input"
  run context_extractor.sh "${BATS_TEST_TMPDIR}/input" 1

  echo "output = ${output}"
  [ "$output" = $'## Heading two' ]
}

@test "section with code block prints code block as part of section" {
  echo -e '# Heading\n\n```\n# Code\n## Code\n```' > "${BATS_TEST_TMPDIR}/input"
  run context_extractor.sh "${BATS_TEST_TMPDIR}/input" 1

  echo "output = ${output}"
  [ "$output" = $'# Heading\n\n```\n# Code\n## Code\n```' ]
}
