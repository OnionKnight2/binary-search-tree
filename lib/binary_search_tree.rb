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
    return root_node if root_node.nil?

    if value < root_node.data
      root_node.left = delete(value, root_node.left)
    elsif value > root_node.data
      root_node.right = delete(value, root_node.right)
    else
      # Node has no children or one child
      return root_node.right if root_node.left.nil?
      return root_node.left if root_node.right.nil?

      # Node has two or more children
      # Get the inorder successor
      # (smallest in the right subtree)
      temp = minValueNode(root_node.right)

      # Copy the inorder successor's
      # content to this node
      root_node.data = temp.data

      # Delete the inorder successor
      root_node.right = delete(temp.data, root_node.right)
    end

    root_node
  end

  def minValueNode(node)
    node = node.left until node.left.nil?

    node
  end

  def find(value, root_node = @root)
    return root_node if root_node.nil? || root_node.data == value

    value < root_node.data ? find(value, root_node.left) : find(value, root_node.right)
  end

  def level_order(root_node = @root, queue = [])
    print "#{root_node.data} "

    queue.push(root_node.left) unless root_node.left.nil?
    queue.push(root_node.right) unless root_node.right.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

  def inorder(root_node = @root)
    return if root_node.nil?

    inorder(root_node.left)
    print "#{root_node.data} "
    inorder(root_node.right)
  end

  def preorder(root_node = @root)
    return if root_node.nil?

    print "#{root_node.data} "
    preorder(root_node.left)
    preorder(root_node.right)
  end

  def postorder(root_node = @root)
    return if root_node.nil?

    print "#{root_node.data} "
    postorder(root_node.right)
    postorder(root_node.left)
  end

  def height(node = @root)
    return -1 if node.nil?
    
    [height(node.left), height(node.right)].max + 1
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
tree.delete(0)
tree.delete(8)
tree.pretty_print

# p tree.find(9)

puts tree.level_order

puts tree.inorder
puts tree.preorder
puts tree.postorder

puts tree.height(tree.find(23))