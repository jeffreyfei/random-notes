# Pipes

## Anonymous Pipes

- Provid ebuffering and loose synchronization between the producer (upstream), and consumer (downstream)
    - Producer blocks when writing to a fuill pipe
    - Consumer blocks when reading an empty pipe
    - Consumer receives EOF when upstream is closed

```c
int p[2];
pipe(p);
```

- Returns 0 on success and -1 on error

- `p[1]` is the input of the pipe; `p[2]` is the output

## Copying File Descriptors

```c
dup(fd);
```

- Copies `fd` onto the lowest available descriptor

```c
dup2(fd1, fd2);
```

- Copies `fd1` onto `fd2`
- `fd2` gets closed first if it's open

### Example: Redirect stdin

```c
int fd;
fd = open("foo", ...);
close(0);
dup(fd); // guaranteed to be 0 as 0 is the lowest closed
```

```c
int fd;
fd = open("foo", ...);
dup2(fd, 0);
```

- Note: 1 is stdout

## Named Pipes

- Have an entry in the file system
- Unidirectional
- Loose synchronization
    - Opening either end blocks until the other end is opened
- Uses `read()` and `write()` calls

- Used in Client/Server model

- Linux guarantees that at least `PIPE_BUF` bytes can be written to the pipe *atomically*

```c
mkfifo("/path/to/pipe", 0644);
```

- Can be created over command line using `mkfifo <path/to/pipe>`