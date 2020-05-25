# Identity

## Process of Querying User Identity

1. Program talks to resolver
2. Resolver reads the nsswitch.conf file
3. The nssswitch.conf file directs resolver to the information that it need
    - e.g. Local file, LDAP, NIS

```c
getpwnam("alice"); // Querying by user name

getpwuid(614); // Querying by user ID
```

- Both returns `struct passwd`; returns `NULL` if not found

```c
getpwent();
```

- Returns the next account from the database
- Usually used in a loop to step through the user list
- Returns NULL at the end
- `setpwent()` can be used to rewind the list to be beginning

### Querying Groups

```c
getgrnam("students"); // Querying by group name

getgruid(614); // Querying by group ID
```

- Returns a `struct group`

```c
getgrent(); // Step through the group

setgrent(); // Rewind
```

## Process Identity

- Real User ID - the user that the process is running on the behalf of
- Effective User ID - the identity that the user may have borrowed under certain circumstances (e.g. root)

- Normally a process inherits the *real* user ID across a `fork()` and an `exec()`
    - *Effective* user ID can be inherited if the `setuid` bit is turned on

```c
getuid(); // Real User ID
getgid(); // Real Group ID
geteuid(); // Effective User ID
getegid(); // Effective Group ID
```

- The initial effective ID after an `exec()` is remembered by the process as the `saved set-user-ID`
    - The process can switch its effective user ID between the real ID and the saved set-user-ID by `seteuid(uid)`

# File Permissions

- Permissions are set explicitly in `open()` and `creat()`
- `fopen()` always set permission to `0666`

```c
chmod("user", 400);
```

### umask

- umask is a bit mask of permissions *not* to be assigned
    - Represented by an octal constants

- the requested mode will get applied bitwise and with the 1's complement of the umask, resulting in the assigned mode

# File Ownerhsip

- The owner of a new file is the effective UID of the process that creates it
- The group of a new file depends on the `setgid` bit
    - `setgid ? inherited from the parent dir : effective GID of the process`

```c
chown("foo", 504, -1); // follows symlinks

lchown("foo", 504, -1); // does not follow symlinks
```

- "foo" is the user name
- 504 is the new UID
- -1 is the new group ID (-1 means don't change)