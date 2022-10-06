class Node
  attr_accessor :coordinates
  attr_accessor :children
  attr_accessor :parent
  def initialize(coordinates=nil, children=[], parent=nil)
    @coordinates = coordinates
    @children = children
    @parent = parent
  end

  def spawn_children
    destinations = knight_destinations(@coordinates)
    legal_destinations = keep_legal_moves(destinations)
    # p legal_destinations
    # p @children
    legal_destinations.each { |d| @children << Node.new(d, [], self) }
  end

  def knight_destinations(coordinates)
    deltas = [[-2,-1], [-2, 1], [-1,2], [-1,-2], [1,2], [1,-2], [2,1], [2,-1]]
    return deltas.map { |d| [d[0]+coordinates[0], d[1]+coordinates[1]]}
  end

  def keep_legal_moves(destinations)
    legal_moves = []
    destinations.each do |d| 
      if d[0] >= 0 && d[0] <= 7 && d[1] >= 0 && d[1] <= 7
        legal_moves << d
      end
    end
    return legal_moves
  end

end

class Tree

  def initialize(start_coordinates, target_coordinates)
    @root = Node.new(start_coordinates)
    @target = build_tree(start_coordinates, target_coordinates)
  end

  def build_tree(start_coordinates, target_coordinates, parent=nil)
    arr = [@root]
    while !arr.empty?
      if arr[0].coordinates == target_coordinates
        return arr[0]
      end
      arr[0].spawn_children
      arr[0].children.each { |n| arr << n }
      arr.shift
    end
  end

  def depth(node)
    current = node
    count = 0
    while current.parent != nil
      current = current.parent
      count += 1
    end
    return count
  end

  def move_list(node=@target)
    current = node
    list = []
    list << node.coordinates
    p list
    while current.parent != nil
      current = current.parent
      # p current.coordinates
      list << current.coordinates
    end
    return list.reverse()
  end

end

start = Node.new([3,3])
start.spawn_children

tree = Tree.new([3,3], [4,3])
p tree.move_list
