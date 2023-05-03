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

  def depth(root_node = root, current_root = root, counter = 0)
    return -1 if root_node.nil?
    return counter if root_node == current_root || current_root.nil?

    if root_node.data < current_root.data
      counter += 1
      depth(root_node, current_root.left, counter)
    else root_node.data > current_root.data
      counter += 1
      depth(root_node, current_root.right, counter)
    end
  end

  def balanced?(root_node = root)
    return true if root_node.nil?

    left_height = height(root_node.left)
    right_height = height(root_node.right)
    return false if (left_height - right_height).abs > 1

    balanced?(root_node.left) && balanced?(root_node.right)
  end

  def rebalance
    self.data = inorder_array
    self.root = build_tree(data)
  end

  def inorder_array(root_node = root, array = [])
    unless root_node.nil?
      inorder_array(root_node.left, array)
      array.push(root_node.data)
      inorder_array(root_node.right, array)
    end
    array
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

# Driver script
array = Array.new(15) {rand(1..100)}
bst = Tree.new(array)

bst.pretty_print

puts bst.balanced?

puts bst.level_order
puts bst.preorder
puts bst.inorder
puts bst.postorder

bst.insert(123)
bst.insert(126)
bst.insert(135)
bst.insert(140)
bst.pretty_print

bst.rebalance
bst.pretty_print

puts bst.level_order
puts bst.preorder
puts bst.inorder
puts bst.postorder