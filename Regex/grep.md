# grep

- Allows you to search output or files

## Piping

```bash
cmd_with_output | grep "pattern"
```

`-i` - case insensitive

`-v` - exclude the pattern

## Search File

```bash
grep file1 file2 dir/* ...  "pattern"
```

- Can include multiple files or directories to search

`-c` - counting the number of occurrences
