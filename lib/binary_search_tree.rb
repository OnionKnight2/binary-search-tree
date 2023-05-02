# frozen-string-literal: true

class Tree
  attr_accessor :data, :root
  def initialize(array)
    @data = array.uniq.sort
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.length.eql?(0)

    mid = array.length / 2
    
    root_node = Node.new(array[mid])
    root_node.left = build_tree(array[0...mid])
    root_node.right = build_tree(array[(mid+1)...array.length])

    root_node
  end

  def insert(value, root_node = @root)
    # If a accepted value already exist, return nil
    return nil if value == root_node.data

    if value < root_node.data
      # Traverse the left subtree
      root_node.left.nil? ? root_node.left = Node.new(value) : insert(value, root_node.left)
    else
      # Traverse the right subtree
      root_node.right.nil? ? root_node.right = Node.new(value) : insert(value, root_node.right)
    end
  end

  def delete(value, root_node = @root)
    
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end  
end

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
tree.insert(123)
tree.insert(0)
tree.insert(2132)
tree.pretty_print