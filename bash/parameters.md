# Parameters

`$*`
- Gives all parameters `$1 $2 $3... $N`
- Strings with spaces with become separate words

`$@`
- Same as `$*` when unquoted
- `"$@"` will treat string with spaces as a single word
- More preferable to use

### getopts

```bash
shift $(( OPTIND -1 ))
```

- Use this after handling getopts options to parse the rest of the arguments manually