# Time

```c
time(NULL); // Returns the number of seconds since the epoch (12:00am, 1 Jan 1970 UTC)
```

### Broken down time

```c
gmtime(t); // UTC

localtime(t); // Local time zone
```

- returns a `struct tm`; [Details here.](http://www.cplusplus.com/reference/ctime/tm/)

### Human Readable Time

```c
ctime(t);
```

- returns a human readable string; no control over format

### Process Time

```c
times(buf);
```

- Returns a `struct tms`; [Details here.](http://www.cplusplus.com/reference/ctime/tm/)

- user time - time spent executing instruction in user space
- system time - time spent executing on the kernel on behalf of the process