# Control Flow

- Loops and case (switch) statements

### C style for loop

```bash
for (( INIT; TEST; UPDATE)); do
    # Do something
done

# e.g.

for (( i=0; i<length; ++i )); do
    echo ${i}
done
```

### Case statements

```bash
case WORD in
    PATTERN1)
        # Do sometihng ;;
    PATTERN2)
        # Do something;;
```

- Add `)` after each pattern
- Pattern supports pattern matching
- Add `;;` at the end of the code block to prevent fallthrough (like the `break` in `switch` statements)