# Functions
## Multiple return values
```go
func my_func(sum int) (int, int) {
  return sum * 4 / 9, sum - x
}
// Usage
x, y := myFunc(3)
```
- The return values are assigned to x, y in the respective order they are returned
## Named return values
```go
func my_func(sum int) (x, y int) {
  x = sum * 4 / 9
  y = sum - x
  return // refered to as a naked return
}
// usage
x, y := myFunc(3)
```
- x, y are the return values
- a naked return will return both x and y
## Variadic Functions
```go
func sum(sums ...int) {
  total := 0
  for _, v range sum {
    total += sum
  }
  return total
}
// Usage
total := sum(1, 2, 3, 4, 5)
```
- sum is passed in as a slice
## Function parameters
```go
func Op(a int, b int, do func(int, int)) {
  return do(a, b)
}
func Plus(a int, b int) {
  return a + b
}
func Minus(a int, b int) {
  return a - b
}
// Usage
sum := op(1, 2, plus)
```
## Function type
```go
type Op func(int, int)()

func Plus2(a int, b int) Op {
  // Need to match the signature of Op
  return func(a int, b int) {
    return a + b + 2
  }
}

sum := Plus2(1, 2)() // will return 5
```
## Methods
```go
type MyType struct {
  x int
  y int
}

func (type MyType) MyFunction() (int, int) {
  return type.x, type.y
}

myVar := NamedType{}
x, y := myVar.MyFunction()
```
- Declaring a function with a named type means that the function can only operate on that type
- We can't mutate the value of the named type
  - But if we pass in a pointer (Called a *pointer receiver*), then we can modify the value of the type within the function
```go
func (type *MyType) ChangeValue(x int, y int) {
  type.x = x
  type.y = y
}
```
# Zero values
- variables are given their zero values if not given an initial value
  - numeric -> 0
  - bool -> false
  - string -> ""
# Arrays
```go
  arr := [2]{1, 2}
  len(arr) // length of the array
  cap(arr) // capacity of the array
```
# Slices
```go
[<starting_index>:<ending_index> + 1]

numbers := [6]{1, 2, 3, 4, 6}
s := numbers[1:3] // This gives [2, 3]

// Can omit higher/lower bounds
// Default is 0 for lower and length for higher
a := numbers[:3]
b := numbers[1:]
```
- Slices are references to the original array, therefore mutations on the slice will be reflected on the original array
```go
var s []int
append(s, 1) // Append 1 to the slice
append(s, 2, 3, 4) // Append multiple values to the slice
```
## Remove an item from a slice
- Must append two sliced slices
```go
func remove(i int, slice []int) []int {
  return append(slice[:i], slice[i+1:])
}
```

# Loops
## Basic for loops
```go
// Regular for loop
for i:= 0; i < 25; i++ {
  fmt.Prinf("%d", i)
}

// This acts like a while loop in other languages
for i == 25 {
  i++
  fmt.Prinf("$d", i)
}

// Infinite loop
for {
  if i == 25 {
    break
  }
}

```
## Range
```go
var my_array = []int {1, 2, 3, 4, 5}
for i, v := range my_array {
  // i returns the index
  // v returns the value corresponding to the index i
}  
for _, v := range my_array {
  // _ drops the index
}
```

# Closures
```go
func adder() func(int) int {
  sum := 0
  return func(x int) int {
    sum += x
    return sum
  }
}

func main() {
  number := adder()
  number(1) // 1
  number(5) // 6
  number(1) // 7
}
```

# Types
## Methods
```go
type Vertex struct {
  X, Y float64
}
// A regular receiver returns a value
func (v Vertex) Abs() float64 {
  return Math.sqrt(v.X*v.X + v.Y*v.Y)
}
// A pointer receiver mutates the original struct
func (v *Vertex) Scale(f float64) {
  v.X = v.X * f
  v.Y = v.Y * f
}
```
# Pointers
- Methods with value receivers can be used with values or pointers
```go
  var v MyType
  v.MyMethod() // valid
  p := &v
  p.MyMethod() // valid, interpreted as (*p).MyMethod()
```

# Control Flow
## Switch statements
- Breaks on each case by default
  - The keyword "fallthrough" is needed at the end of the block for the statement to fallthrough
- Empty switch evalutaes to true
```go
switch {
  case sum == 1:
    return "one"
  case sum == 2:
    return "two"
  default:
    return "others"
}
```
- Multiple conditions can be specified for one case
```go
switch {
  // ...
  case sum == 1, sum == 2:
    // some code
  // ...
}
```
- Switch can be performed based on type

```go
// An interface can be of any type
func my_function(x interface{}) {
  switch x.(type) {
    case string:
      return "It's a string"
    case int:
      return "It's an int"
    default:
      return "Unknown"
  }
}
```

# Interface
- An interface outlines certain methods
- Any type that implements the methods outlined in the interface will implement the interface automatically
```go
type MyType struct {
  x int
  y int
}

type Mutable interface {
  ChangeValue(x int, y int)
}

// This makes MyType implement the Mutable interface
func (type *MyType) ChangeValue(x int, y int) {
  type.x = x
  type.y = y
}

func ChangeTo12(m Mutable) {
  m.ChangeValue(1, 2)
}

myVar := MyType{}
// Since ChangeValue takes in a pointer, we need to deref myVar
ChangeTo12(&myVar)
```
## Empty Interface
- Since an empty interface has no requirements, every type implements this interface
  - In other words an empty interface can be of any type

# Concurrency
- Go handles concurrency by only allowing one thread to handle a particular data, and use a communication channel between different threads to share the state of the data
## Goroutines
```go
go function_call()
```
- This executes the statement in a separate non-blocking thread

## Channels
- Can be used to send data asynchronously betwen different threads
``` go
// Specifies the data that would be sent through the channel, which is a bool
done := make(chan bool)

go func() {
  fmt.Printf("This is an aysnc thread!")
  // Sends the data to the channel
  done <- true
  // This line will not be executed until the channel has been read
  fmt.Printf("Done!")
} ()

<- done // Can be assigned to a variable, the code blocks until data is available in the channel
```
### Buffered Channels
- To send multiple pieces of data through the channel we need a buffered channel

```go
// This specifies that the channel can take in two items before it has to be read
done := make(chan bool, 2)
```

### Channel with Range
```go
c := make(chan int)
go func() {
  for int i = 0; i < 100; i++ {
    c <- i
  }
  // This sends an indication to the reader for loop that all data has been sent
  close(c)
} ()

// Will read the channel until it receives a close signal
for i := range c {
  fmt.Printf("%d", i)
}
```

## Select Statement
### Three rules of select
- If a case is "ready", that case will be executed
- If more than one case is ready, a case will be executed at random
- If no case is ready and a default statement is not defined, it will block until a case is ready

```go
c1 := make(chan int)
c2 := make(chan int)

go func() {
  for int i = 0; i < 100; i++ {
    c1 <- i
  }
  close(c1)
} ()

go func() {
  for int i = 0; i < 100; i++ {
    c2 <- i
  }
  close(c2)
} ()

for {
  select {
  // Ok indicates whether if the channel is still open
  case i, ok := <- c1:
    if ok {
      fmt.Println("Channel 1: %d", i)
    } else {
      return
    }
  case i, ok := <- c2:
    if ok {
      fmt.Println("Channel 2: %d", i)
    } else {
      return
    }
  default:
    fmt.Println("waiting")
  }
}
```