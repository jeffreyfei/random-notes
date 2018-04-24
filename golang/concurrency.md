# Basics
## Communicating Sequential Processes (Actor)
- Contains actors
    - Receive information, process information, and pass the processed information onto the next actor in the chain
    - Actors does not have to be concurrent internally

### Advantages
- Fully decoupled
    - Actors does not need to know about each other, they only need to know where to get messages from, and where to send the messages to

- Multiple Handlers
    - Can have different numbers of message generators and message consumers

- Memory isolation
    - A message is only available to one actor at a time

### Disavantages
- Complicated mental model
- Traceability
    - Hard to track the flow of messages in a complicated application

## Concurrency in Go
- No Thread Primitives
    - Cannot directly manipulate processor thread
- Goroutines
    - Thread like constructs
    - Virtual threads
    - Handled by go runtime, does not have a 1 to 1 relation to memory threads
- Channels
    - Allow strongly typed message to pass through it


# Goroutines
- **GOMAXPROCS** sets the number of logical processors that the go process can use
    - By default, a go application can only run on a single logical processor

```go
// Allows the processes to run in parallel on 2 logical processors
runtime.GOMAXPROCS(2)
```
- Common issue when implementing Goroutines within for loops
```go
for i := 0; i < 5; i++ {
    go function(i int) {
        some_async_call(i)
    } (i)
}
```
- Note here i is declared as a parameter of the anonymous gouroutine function
- If i is used directly, and the async call that uses i is slow, there is a chance that all the iterations of the loop finishes running before the first async call is finished. In that case all the async calls will be using the final value of i (In this case 4)
- By declaring i as a parameter, the value of i is captured during the initialization of the goroutine

# Channels
- For basic channel implementation, check go.md

# Concurrency Design Patterns
## Mutex Lock with Goroutine
```go
package main

import (
    "fmt"
    "runtime"
    "sync"
)

func main() {
    mutex := new(sync.Mutex)
    runtime.GOMAXPROCS(4)

    for i := 1; i < 10; i++ {
        for j := 1; j < 10; j++ {
            mutex.Lock()
            go func() {
                fmt.Printf("%d + %d = %d\n", i, j, i+j)
                mutex.Unlock()
                // The next Goroutine 
            }()
        }
    }
}
```
## Events in Go
```go
type Button struct {
    // Each button holds multiple topics
    // Each topic contains mutiple event listeners subscribed to it
    eventListeners map[string][]chan string
}

func MakeButton() *Button {
    btn := new(Button)
    btn.eventListeners = make(map[string][]chan string)
}

func (this *Button) AddEventListener(event string, responseChannel chan string) {
    // If the event exist, append the new channel onto the array
    // Else create the event with the channel
    if _, present := this.eventListeners[event]; present {
        this.eventListeners[event] = append(this.eventListeners[event], responseChannel)
    } else {
        this.eventListeners[event] = []chan string{responseChannel}
    }
}

func (this *Button) DeleteEventListener(event string, responseChannel chan string) {
    // If the event exists, find the channel and remove from the array
    if _, present := this.eventListeners[event]; present {
        for i, channel := range this.eventListeners[event] {
            if channel == responseChannel {
                this.eventListeners[event] = append(this.eventListeners[event][i], 
                    this.eventListeners[event][i+1])
            }
        }
    }
}

func (this *Button) TriggerEvent(event string, response string) {
    // If the event exists, send the reponse through every channel
    if _, present := this.eventListeners[event]; present {
        for _, channel range this.eventListeners[event] {
            go func(channel chan string) {
                channel <- response
            }(channel)
        }
    }
}
```

## Simulate Callbacks
```go
func main() {
    ch := make(chan int)
    go myCallback(ch)
    // This causes the main function to wait until the async call is completed
    result := <- ch
}

func myCallback(callback chan int) {
    callback <- someAsyncCall()
}
```

## Simulate Promises

```go
func main() {
    po := new(PurchaseOrder)
    po.Value = 42.27

    SavePO(po).Then(func(obj interface{}) error {
        po := obj.(*PurchaseOrder)
        fmt.Printf("Order saved")
    }, func(err error) {
        fmt.Printf("Failed to save order : " + err.Error())
    })
}

type PurchaseOrder struct {
    Number int
    Value float64
}

func SavePO(po *PurchaseOrder) *Promise {
    result := new(Promise)
    result.successChannel = make(chan interface{}, 1)
    result.failureChannel = make(chan error, 1)

    go func() {
        if po, err := someAsyncCall(); err != nil {
            result.failureChannel <- err
        } else {
            result.successChannel <- po
        }
    }
}

type Promise struct {
    successChannel chan interface{}
    failtureChannel chan error
}

func (this *Promise) Then(success func(interface{}) error, failure func(error)) *Promise {
    result = new(Promise)
    result.successChannel = make(chan interface{}, 1)
    result.failureChannel = make(chan error, 1)

    go func() {
        select {
            case obj := <-this.successChannel:
                newErr := success(obj)
                if newErr == nil {
                    result.successChannel <- obj
                } else {
                    result.failureChannel <- newErr
                }
            case err := <- this.failureChannel:
                failure(err)
                result.failureChannel <- err
        }
    } ()
}
```