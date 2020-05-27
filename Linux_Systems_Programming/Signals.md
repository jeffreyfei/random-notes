# Signal
- An event delivered to the process by the kernel
- Can have various sources but is always delivered by the kernel

## Signal Types

- Can be viewed by typing `kill -l` in the command line

### A couple of important ones

- `SIGINT (2)` - the signal sent by ^C on terminal
- `SIGFPE (8)` - arthmetic error (e.g. divide by zero)
- `SIGKILL (9)` - lethal signal, cannot be caught or ignored
- `SIGSEGV (11)` - invalid memory reference
- `SIGTERM (15)` - polite "please terminate" signal

## Sending Signals

```c
kill(3644, 15);
```

- `3644` is the target PID
- `15` is the signal number (0 can be used here to test for process existence)

## Signal Handler

```c
signal(SIGHUP, hup_handler);
```

- `SIGHUP` - the signal that will be handled
- `hup_handler` - a pointer to the handler function; or one of the following:
    - `SIG_IGN` - ignore signal
    - `SIG_DFL` - restore default

### Handler structure
```c
void handler(int sigtype)
{
    // Handle the signal
    return;
}
```

- The function must be of type `void` and takes an `int` argument
- Signal delivery is async and can happen any time during the program execution
    - If signal deliver happens during a blocking operation (e.g. `read()`),
    the operation will fail with an error, returning a -1

### Alternative Handling Function

```c
sigaction(SIGHUP, &newact, &oldact);
```

- `&newact` and `&oldact` are of `struct sigaction`
    - [Details here](https://www.man7.org/linux/man-pages/man2/sigaction.2.html)

- Within `&newact`
    - `sa_handler` - the signal handler or `SIG_IGN` / `SIG_DFL`
    - `sa_mask` - set of signals to be block during the execution of the handler
    - `sa_flags` - optional flags

- `&oldact` - gets the old handler info; NULL if not needed

## Signal Sets

- `sigset_t` is an array of booleans representing a set of signals
- [Details here](https://www.gnu.org/software/libc/manual/html_node/Signal-Sets.html)

## Blocking signals

- Each process has a signal mask - a set of signals currently from from delivery
- Blocked signals and held pending and will be delivered when unblocked
    - Multiple pending signals of the same type are not queued

```c
sigprocmask(how, set, oldset)
```
- Add or remove signals from the mask

- how
    - `SIG_BLOCK` - add to the mask
    - `SIG_UNBLOCK` - remove from the mask
    - `SIG_SETMASK` - Assign this signal set to the mask

- set - the set of signals to add/subtract
- oldset - the previous mask is returned here
