# File System

- inode - a datastructure that holds the file's attribtues (permission, owner, timestamp etc.)

- directory contains links to inodes (refererenced by filename and inode number)

```c
stat(name, buf)
```

name - pathname of the file to be opened

buf - pointer to a stat structure

```c
fstat(fd, buf)
```

fd - open file descriptor

- returns 0 on success -1 on failure

- [Details on struct stat](http://codewiki.wikidot.com/c:struct-stat)

## File Types and Permission

- Information on the file type and permission is stored in the `st_mode` field in the stat structure

- The status of a particular file permission can be obtained from bitwise and with the bit mask
    - [Details](https://docs.microsoft.com/en-us/cpp/c-runtime-library/stat-structure-st-mode-field-constants?view=vs-2019)



## Creating Files

```c
open(name, flags, mode)

creat(name, mode)
```

name - path name

flags - includes `O_CREAT`

mode - access mode of the file

## Links

- Associates a name to an inode number

```c
link(oldname, newname); // Gives the file an additional name

unlink(name); // If this is the last remaining link the file is deleted
```

- There can be more than one link to a file

- Additional links cannot be created to directories

## Symlinks

- A symbolic link is a small file that contains the name of another file
    - Has its own inode

- Can link to directories
- Can link across file system boundries
- Associates a name with another name

```c
symlink(oldname, newname);

unlink(name); // only the symlink is removed, not the file
```

- Some system calls follow symbolic links
    - e.g. `open()`, `read()`, `write()`
    - some calls such as `unlink()` do not

## Directory Traversal

### Current Directory

```c
getcwd(buf, size);
```

- Get the current directory path

buf - where the result will be returned (pathname)

size - size of the buffer (usually use `PATH_MAX`)

```c
chdir(pathname);
```

- Change the current directory

pathname - path name of the new current directory

```c
mkdir(name, mode);
```

- Create *one* directory

```c
rmdir(name);
```

- Remove the directory

### Reading Directories

```c
d = opendir(dirname); // Open the directory

info = readdir(d); // Read one file in the directory
```

- Needs a loop to read all files in the directory

## Monitor File System Events

- The inotify API is used for this purpose

- Not a recursive process

### Initialization
```c
fd = inotify_init(); // Create a inotify instance
```

- Returns a file descriptor that we can later access by using `read()`

### Create a watch item
```c
wd = inotify_add_watch(fd, path, mask); // Add a watch item
```

fd - file descriptor of the inotify instance

path - name of file or directory to be watched

mask - bit mask specifying the events to be monitored ([Check here](http://man7.org/linux/man-pages/man7/inotify.7.html))

- Returns a watch descriptor

### Read events

```c
n = read(fd, buf, size);
```

fd - file descriptor of the inotify instance

buf - buffer that the [inotify_event structure](http://www.qnx.com/developers/docs/qnxcar2/index.jsp?topic=%2Fcom.qnx.doc.neutrino.lib_ref%2Ftopic%2Fi%2Finotify_event.html) will be written to

   - The records can be of variable length

- Blocks until an event occurs
- Can return more than one events