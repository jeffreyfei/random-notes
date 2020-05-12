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

## Conditional

`|` - OR, can be used to match two sets of patterns

e.g. Matches HTML colour codes of length 3 and 6
```
    #?([A-F0-9]{6}|[A-F0-9]{3})
```

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