## Range

`[]` - Group range of acceptable characters e.g. `[A-Z0-9]`

`[^]` - Negation e.g. `[^A-Z]`


## Quantifier Characters

- Placed after the matching pattern

`?` - Match 0 or 1 times

`*` - Match 0 or more times

`+` - Match 1 or more times

`{n}` - Match exactly n characters

`{n,}` - n or more times

`{n, m}` - Between n and m times

`{,m}` - Between 0 and m times

## Branching

`|` - OR, can be used to match two sets of patterns

e.g. Matches HTML colour codes of length 3 and 6
```
    #?([A-F0-9]{6}|[A-F0-9]{3})
```

- Has the lowest precedence of all operators
- Place longer matches first

## Pattern modifier

`/<pattern>/i` - Case insentitive

## Anchoring

`^` - Anchoring to the beginning of the string
`$` - Anchoring to the end of the string

e.g. `/^pattern$/` - Only match the entire string

## Shorthand Code

`\s` - all kinds of whitespace

## Wildcard

`.` - Match any character except for `\n`, (will match `\n` with dotall modifier)

## Engine Differences

- PCRE - first match

- POSIX - longest match

## Grouping

`()` - Patterns within the parenthesis are treated as one unit

## Short codes

`\d` - numbers `[0-9]`

`\w` - alpha numeric `[A-Za-z0-9]`

`\s` - spaces `[\t\f\r\n]`

`\D` - negated `\d`

`\W` - negated `\w`

`\S` - negated `\s`

### PCRE 7.2+

`\h` - horizontal spaces `[\t\f]`

`\v` - vertical spaces `[\r\n]`

## Modifiers

### Gobal

- `g`
- returns all matches instead of just the first
- non-overlapping

### Case Insensitive

- `i`
- May not recongnize non ascii variations

### Multiline

- `m`
- Affects `^` and `$` behaviour
- Matches each line of the input (separated by `\n`) instead of the entire input string

### Dotall / Singleline

- `s`
- Affects `.` to match `\n`

### Extended

- `x`
- All white spaces in the pattern gets ignored
- Better readability via multi-line regex
- Supports inline comment using `#`