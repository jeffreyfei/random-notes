# Accessing Files

```c
fd = open(name, flags, mode)
```

name - path of the target file

flags - must include one of O_RDONLY, O_WRONLY, O_RDWR; 
        optional: O_APPEND, O_CREAT, O_TRUNC

fd - lowest available file descriptor; 0 - keyboard, 1 - stdout, 2 - stderr

```c
read(fd, buffer, count)

write(fd, buffer, count)
```

buffer - pointer to buffer

count - size of the buffer

### Random Access

```c
lseek(fd, offset, whence)
```

offset - a byte offset (can be positive or negative)

whence - where the offset is relative to; SEEK_SET - start of file, SEEK_CUR - current position, SEEK_END - end of file

- If the offset points to a position beyond the EOF
    - If you do a read EOF will be returned immediately
    - If you do a write the file gets extended, the "hole" in between the new position and the old EOF will return 0s