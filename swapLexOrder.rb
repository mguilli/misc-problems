
str = "dznsxamwoj"
pairs = [[1,2], 
 [3,4], 
 [6,5], 
 [8,10]]

def find_paths(pairs)
  # create graph of nodes and edges
  nodes = Hash.new([])
  
  pairs.each do |a,b|
    nodes[a] += [b]
    nodes[b] += [a]
  end

  paths = []
  vns = [] # visited nodes
  
  # Traverse edges using a queue to document all existing paths between pairs
  nodes.each do |node, edges|
    next if vns.include? node
    q = edges.clone

    q.each do |edge|
      next if vns.include? edge
      vns << edge
      (q << nodes[edge]) && (q.flatten!) if nodes[edge].size > 0
    end

    # convert to base-0 indexing and store queue to paths
    paths << q.sort.uniq.map {|z| z - 1}
  end
  return paths
end

def swapLexOrder(str, pairs)
  paths = find_paths(pairs)

  # for each path, extract the associated letter at the index, sort decreasing, and replace back into str
  paths.each do |path|
    temp = []
    
    path.each {|i| temp << str[i]}
    temp.sort!.reverse!
    path.each_with_index {|v,i| str[v] = temp[i]}
  end
  return str
end

swapLexOrder(str, pairs)
