# Processes

- A process contains
    - Process ID (PID)
    - Real User Idea - the user that is running the process
    - Effective User ID - defines the permission that it carries
    - Current directory
    - Priority
    - Environment (variables)
    - Open streams - e.g. file descriptors from open
    - Signal Dipositions - configs regarding how to process signals
    - Memory regions


- Process memory
    - Heap - hold dynamic data structures
    - Stack - hold local variable of function; last in first out
    - Data - hold global / static variables
    - Code - code that the program is runing

## Process Creation

```c
fork();
```

- In parent, the function returns the PID of child
- In the child, the function returns 0

- The child inherits copies of most things from the parent, except:
    - It shares the code with the parent
    - It is assigned a new PID

## Executing a Program

```c
exec();
```

- Causes the current execution of a process to be replaced by the image of a new program

- Does not return on succeed

- There are 7 different variations of `exec()` with different usecases; [Details here](http://man7.org/linux/man-pages/man3/exec.3.html).

## Termination

```c
exit(n);
```

- Exit process; passes back to parent

n - exit status

```c
int status;
wait(&status);
```

- Call waits until a child process terminates. Returns PID of the child.
- The child exit status is returned here. Pass 0 (NULL) if not interested