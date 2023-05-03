# binary-search-tree
Building a balanced search tree in Ruby

Node class has an attribute for the data it stores as well as its left and right children.

Tree class accepts an array when initialized. 
The Tree class has a root attribute which uses the return value of #build_tree method.

#build_tree method takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) 
and turns it into a balanced binary tree full of Node objects appropriately placed.
It uses #pretty_print method to visualize a tree.

#insert and #delete method accept a value to insert/delete

#find method accepts a value and returns the node with the given value

#level_order method should traverse the tree in breadth-first level order. The method should return an array of values if no block is given

#inorder, #preorder, and #postorder methods traverse the tree in their respective depth-first order. The methods should return an array of values if no block is given.

#height method accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.

#depth method accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node