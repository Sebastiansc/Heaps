# Heaps

Ruby implementation of a BinaryMinHeap. Accepts proc to determine order of elements so it can easily be used as a MaxHeap.

##Heap sort

Sorting algorithm utilizing BinaryMinHeap. Completixity is always O(n logn). Great for cases when consitency is needed.

##Usage

###BinaryMinHeap public facing instance methods

- initialize: Accepts an optional start array. Array must follow heap conditions. Accepts a prc to determine order of elements
- extract: Removes and returns the smallest item in the heap while maintaining heap conditions
- push: Adds a new item to the heap in the correct position
- count: Returns heap item count
- peek: Reads smallest item in heap

###BinaryMinHeap public facing class methods

- heapify_down: Accepts -> array, parent_idx, len, prc. Moves the element in the parent_idx down the heap until it reaches
it's correct place. Len determines the boundary where the swapping will stop (useful for heapsort)
- heapify_up: Accepts -> array, child_idx, len, prc. Moves the element in the child_idx up the heap until it reaches
it's correct place. Len paramter can be ignored for most use cases.
