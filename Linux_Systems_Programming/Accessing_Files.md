# Accessing Files

## Unbuffered IO

- Direct system calls

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

## Standard Lib IO (Buffered)

- Does *user space buffering*
    - Avoids the overhead of system calls

```c
fd = fopen(name, mode)
```

mode - "r" reading, "w" truncate and write, "r+" update

fd - returns NULL on error

```c
fread(buffer, size, num, fd)
```

size - size of object

num - number of objects

```c
fclose(fd)
```

- closes descriptor
- flushes buffer

## Formatted IO

```c
printf(format_string, arg1, arg2, ...)

// Write to a file
fd = fopen(...);
fprintf(fd, "hello");

// Formats string into memory
char[100] buf;
sprintf(buf, "hello");
```

## Scatter / Gather IO

- Read or write multiple buffers of data in a single call
- Atomic
- Impelemented using `readv()` and `wrtitev()`

```c
writev(fd, iov, iocount)
```

iov - an array of iov structures
    - a buffer structure with a base address and length

iocount - number of buffers

```c
mmap(addr, length, prot, flags, fd, offset);
```

- Map the file into memory to be accessed like an array

addr - destination; NULL to allow the kernel to choose the address

length - length of the mapping

prot - specifies what you can do with the mapped in file (PROT_READ, PROT_WRITE)

flags - speicifies if the mapped region can be shared with other processes (MAP_SHARED, MAP_PRIVATE)

fd - file descriptor of the source file

offset - offset within the file

- Returns the destination address