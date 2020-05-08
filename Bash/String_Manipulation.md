# String Manipulation

### Removing part of a string

```bash
${var#pattern} # Removes the shortest match from the beginning of the string

${var##pattern} # Removes the longest match from the beginning of the string

${var%pattern} # Removes the shortest match from the end of the string

${var%%pattern} # Removes the longest match from the end of the string
```

#### Usages

```bash
${file##*.} # Get the extension of a file
${file%.*} # Get the name of a file w/o extension
```