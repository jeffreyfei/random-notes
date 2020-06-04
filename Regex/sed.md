# sed

- No changes will be made without the `-i` option
- A backup file can be created by inserting `-i.bak`
    - This will create a backup file called `<og_filename>.bak`, the `bak`
    extension is customizable

## Printing
```bash
sed -n ' p ' <file>
```

- `-n` - surpresses stdout; useful when using the print option

```bash

sed -n '1,5 p ' <file>
```

- only print from line 1 to 5

```bash
sed -n '/^a[0-9]/ p ' <file>
```
- print all lines that matches the regex

## Substitution

```bash
sed ' [range] s/<string>/<replacement>/ ' <file>
```

- The delimeter of the regex is the first character after `s`

```bash
# e.g. alternative delimeter

sed ' s@/bin/bash@/bin/sh@ ' <file>
```

## Append

```bash
sed ; /<pattern>/ a <string>' <file>'
```

- Append string as a line after the pattern

## Insert

```bash
sed ' /<pattern>/ i <string>' <file>'
```

- Insert string as a line before the pattern

```bash
sed ' /<pattern>/d ' <file>
```

- Delete the line from the file matching the pattern

## sed Control files

- sed commands can be inserted into a file, which can be later referenced
using the `-f` option in the sed command

```bash
sed -f ntp.sed /etc/ntp.conf # applies ntp.sed on ntp.conf
```
