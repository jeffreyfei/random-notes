## Stacks & Queues

### 3.4 Queue via Stacks

My Solution:

* Optimized multiple pops by leaving the two stacks as they are before push is called

```
	pseudo code
    
    stack new // newest item on top
    stack old // oldest item on top
    
    function pop() {
		if new.isEmpty() && old.isEmpty {
        	// base case: return null
        } else if !new.isEmpty() && old.isEmpty() {
			// pop every item from new and push onto old, then pop top item from old
        } else if new.isEmpty() && !old.isEmpty() {
        	// pop from old and return item
        } else {
        	// return error, this case can be ignored
        }
    }

	function push() {
    	if new.isEmpty() && !old.isEmpty() {
        	// push every item from old and push onto new, then push onto new
        } else {
        	// push onto new
        }
    }
```

### 3.5 Sorted Stack

My Solution:

* Insertion sort
* Assume temp. variable is allowed

```
	//pseudo code
	stack original
    stack sorted
    
    while (!original.isEmpty()) {
    	temp = original.pop()
        if (sorted.isEmpty() || sorted.peek() >= temp) {
        	// base case
            sorted.push(temp)
        } else {
        	itemsMoved = 0 // counter
            // push every item that is larger than the current sorted item onto the old stack
        	while (!sorted.isEmpty() && sorted.peek() < temp) {
				original.push(sorted.pop())
				itemsMoved++
            }
			// insert the item
            sorted.push(temp)
			// push the temporary items in the old stack back onto the sorted stack
            while (itemsMoved > 0) {
            	sorted.push(original.pop())
                itemsMoved--
            }
        }
    }
```

Improved solution from book:

* Move the second nested while loop outside the enclosing while loop. Since items that are pushed back to the original stack will be push back by the logic of the outer while loop.

### 3.6 Animal Shelter

My solution:

* Same as the book
* Separate queues, timestamp on each animal

## Trees and Graphs

* A **balanced tree** does not have to have perfect balanced size on both sides, as long as it is balanced enough to ensure O(log n) complexity
* **Complete binary tree**: every level of the tree filled (except for the last which could remain empty)
* **Full binary tree**: every node has either 0 or 2 children
* **Perfect binary tree**: both full and complete

### Traversals

* **In-order**: left, node, right
* **Pre-order**: node, left, right
* **Post-order**: left, right, node

### 4.2 Generate binary search tree from a sorted array

Idea:
* Use the middle element of the array as the root
* Split the array in half (excluding the middle element`)
* Recurse on the two halves of the array

### 4.3 List of depth

My Solution:
* Modify BFS (Very similar to the book's BFS solution)
* Create a vector
* Push root node of tree into vector (need to convert into a linked list node first)
* Iterate through the vector
* If the current list is not null, push a new list onto the vector
* Push the left and right children into the next linked list if they are not nullptr
* Move onto the next list and do the same

### 4.4 Check Balanced

* The definition of a balanced tree is that all subtrees of every node has a height difference of <= 1

Idea:

* Create a check height function that returns the height of a given node
* Create a check balanced function that returns whether a given node is balanced based on the height difference of its children
* If the current node is not balanced, return false. If it is balanced, recurse on both of its children and make sure that they are all balanced
* O(n log n)
* An improved algorithm will be returning an error code as soon as an imbalance is detected on any of the children and force the algorithm to stop

### 4.5 Validate BST

Idea:

* There is a max and min range for each of the nodes in the tree

```
		5
       / \
      3   6
     / \ 
    2   4 
```

e.g. 
The immediate left child (where 3 is) has a range between (-infinity, 5]
The immediate right child of 3 has a range between (3, 5)

* Create a function to validate each node recursively, it will accept a max and min value
* Needs a to represent infinity, in Java the Integer class can be used as it supports a null value. In C++, a custom struct is required
* Check if the current value is within the range, if not return false
* Recurse on both the left and right child, the left child should have a range of (min, currentValue), and the right should be (currentValue, max)
* Return true if both left & right child are valid

### 4.6 Successor

* Find the next element of a given node in a BST

Idea: There are three cases
1. The given node has a right subtree

	* The successor will be leftmost (minimum) node of the right subtree

2. The given node has no right subtree, and is the left child of its parent
	* The sucessor is its parent node

3. The given node has no right subtree, and is the right child of its parent
	* Traverse up the tree until the current node is the left child of its parent, the successor is the parent

* If the traversal reaches the root node before finding the successor, return null

### 4.7 Build Order

Solution 1:

* Assume we have an array of pointers pointing to each project (node)
* Assume incoming edges of each node are its dependencies (must be build before the current node), and outgoing edges are depedent on the current node.
* Assume there exists an attribute in each node that keeps track of incoming edges (e.g. node.dependencies of int type)

1. Construct a build order vector, define an int keep track of the current index (call it toBeProcessed)
2. Initialize the vector by scanning through the array of node pointers, find nodes with no incoming edges, push onto the vector
3. Use toBeProcessed to interate through the vector, for each child of the current node, decrement child.dependencies. If it becomes 0, push it onto the vector.
4. If iteration of the vector is finished, it means we either have cycle or all projects are built. We can check this by scanning through the pointers array again, if there exists a node where node.dependencies > 0, return error. (Can potentially be improved using a set)

* Takes O(P + D) time where P is the number of projects and D is the number of dependency pairs
* Derived from the topological sort algorithm

### 4.8 Common Ancestor

Idea:
* Check left and right children of the current node. If they are contained in different subtrees then the current node is the common ancestor, else recurse on the child that contains both.
`
My solution:

* Initialize a Node pointer and set it to nullptr, this one will be passed into the recusive function by reference.
* A helper function is created that returns an integer flag
	* 0 -> neither a or b is contained in the subtree
	* 1 -> a is contained in the subtree
	* 2 -> b is contained in the subtree
	* 3 -> both are contained in the subtree

1. Base case: the function will return 0 if the current node is null
2. Recurse on the right child and save the return value. If the return value is 3, it means the current node is somewhere down the left subtree, just return 3 (for efficiency).
3. Recurse on the right child and do the same thing as left.
4. Check return value of both right and left. If one is 1 and the other is 2, it means the current node is the common ancestor, set the ancestor pointer to the current node, and return 3 to skip the rest of the steps.
5. Check on the current node, if the current node is a, return left + right + 1. If it is b, return left + right + 2. Else return left + right
6. In the main function, return the ancestor pointer. If no ancestor is found (such as when one of the node does not exist in the tree), the function will simply return nullptr.

* The book 's solution has similar ideas but the function returns nodes instead of integer flags

### 4.9 BST Sequences

Idea:
* Recursive solution
* We know that for each node of every subtree, the root has to go into thel list first, then the two subtree can enter in any order. Therefore the problem can be solve by post order traversal to traverse the deepest leaves and work your way up.
* At each node, generate all possible combinations of the sequences of the two subtrees, and append the current node to the head of each sequences

### 4.10 Check subtree

Idea:
* If a tree is a subtree of a binary tree, it should be a substring of the larger tree
* Can use pre-order traversal to concatentate the string
* A way is needed to determine empty leaves, or else the following case will be non-deterministic

 ```
 		a		a
	   /           \
      b			  b
 ```
* This can be solved by use special markers to indicate empty nodes. Such as 'X' if we assume it is an integer tree


### 4.12 Paths with sum

Idea:
* A bruteforce algorithm will require calculating the sum of every path at every node, the complexity would be O(N log N)
	* Duplicate work are being done every time when you traverse down a node
* Think about an array, notice that the current sum at every element - target sum wil give you the sum required at a previous element to get to your target sum. Therefore if there are two previous elements that sums up the the number, it means there are two paths in the array to your current number that returns the target sum.
* If a datastructure (e.g. hashtable) is used to store the number of a given sum occurs in all previous nodes, one can simply check the number of paths by calculating currentSum - targetSum and query the value from the datastructure

Solution:
1.   If the currentSum == targetSum, increment the pathCount
2.   Calculate currentSum - targetSum, if the key exists in the hashtable, add the number to pathCount
3.   If currentSum exists in the hashTable, increment value. Or else add currentSum to the hashtable with the value 1
4.   Traverse left and right
5.   Decrement the currentSum value in the hashtable (so nodes from other branches won't be counting sums from the current branch)

* This solution will have a runtime of O(N)

## Recursion and Dynamic Programming

### 8.1 Triple Step

Idea:
* Essentially a tree with three branches at each node
* Any path from the root to the leaf is a possible combination of steps
* Use recursion

Memoization Optimization:
* Cache the computed values of the node within a data structure so it's reusable in future computations
* Can produce an O(n) solution, whereas the brute force solution is O(3^n)

* Note the sum will overflow very quickly, bring this up to the interviewer

### 8.3 Magic Index

Idea:
* If the index is unique, the solution will be similar to binary search. Since we know if a[i] = b and b < i, then the index must be on the right side. If b > i, then the index must be on the left side.
* If the index is not unique, we need to search on both side of the pivot. However we can vastly reduce the range of the search:
	* If a[i] = b and b < i, then we know the magical index is somwhere in between [0, b]
	* If a[i] = b and b > i, then we know the magical index is somwhere in between [b, n - 1]

### 8.5 Recursive Multiply

Idea:
* 8 * 9 can be broken down to a tree consists of

```
					8*9
                   /   \
                4*9     4*9
              /     \  /    \
            2*9   2*9 2*9    2*9
           /  \ /  \  / \   /   \
          9   9 9  9  9  9  9    9
          
```
* A recusive algorithm can be constructed using division and addition
* Handle odd numbers e.g. 7*9 = 4*9 + 3*9
* Memoize repeated work
* You will be able to produce something close to O(n/2)