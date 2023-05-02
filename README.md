# binary-search-tree
Building a balanced search tree in Ruby

Node class has an attribute for the data it stores as well as its left and right children.

Tree class accepts an array when initialized. 
The Tree class has a root attribute which uses the return value of #build_tree method.

#build_tree method takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) 
and turns it into a balanced binary tree full of Node objects appropriately placed.
It uses #pretty_print method to visualize a tree.