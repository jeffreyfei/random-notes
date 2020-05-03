# Lambdas

### Basic Syntax

```java
(String param1, String param2) -> {
    System.out.println(param1);
    System.out.println(param2);
}

// Variable Inference

(param1, param2) -> {
    // do something
}
```

* The return values are always inferred
* Blocks with checked exceptions can only be assigned to types that throws the same exception
  * Can also be handled by catching the exception in a helper function



