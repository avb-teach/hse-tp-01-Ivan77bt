#!/bin/bash

INPUT_DIR="$1"
OUTPUT_DIR="$2"

mkdir -p "$OUTPUT_DIR"

find "$INPUT_DIR" -type f | while read FILE; do
  FILENAME=$(basename "$FILE")
  NAME="${FILENAME%.*}"
  EXT="${FILENAME##*.}"

  if [ "$NAME" = "$EXT" ]; then
    EXT=""
  else
    EXT=".$EXT"
  fi

  NEW_NAME="$NAME$EXT"
  COUNT=1

  while [ -e "$OUTPUT_DIR/$NEW_NAME" ]; do
    NEW_NAME="${NAME}${COUNT}${EXT}"
    COUNT=$((COUNT + 1))
  done

  cp "$FILE" "$OUTPUT_DIR/$NEW_NAME"
done