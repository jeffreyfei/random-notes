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

### Search and Replace

```bash
${var/pattern/string} # Substitute first match with the string

${var//pattern/string} # Substitute all matches witht the string
```

### Anchor your Pattern

```bash
${var/#pattern/string} # Matches the beginning of the string

${var/%pattern/string} # Matches end of the string
```

- Meaning where in the string the replacement will start

e.g.
```bash
i="mytxt.txt"

${i/%txt/jpg} # This will replace the extension; result: "mytxt.jpg"
```

### Default values

```bash
${var:-value} # Evaluates to value if var is unset or empty

${var-value} # Only evaluates to value if var is unset

${var:=value} # Evaluates and assigns the default value if empty or unset

${var=value} # Evaluates and assigns the default value if unset
```

### Conditional Expressions

- = and != does pattern matching

```bash
[[ $var = pattern ]] # Pattern matching

[[ $var = "string" ]] # String matching when quotes are added
```

- =~ does regular expression matching