module Geni
  class Family < Base
    def parents
      @parents ||= profiles(walk(focus_node, ['child', 'partner']))
    end

    def partners
      @partners ||= profiles(walk(focus_node, ['partner', 'partner']))
    end

    def children
      @children ||= profiles(walk(focus_node, ['partner', 'child']))
    end

    def siblings
      @siblings ||= profiles(walk(focus_node, ['child', 'child']))
    end
        
    protected
    
    def focus_node
      @nodes[@focus['id']]
    end
    
    def walk(node, rels)
      return node if rels.empty?
      
      node['edges'].collect do |edge_id, edge|
        if edge['rel'] == rels.first && edge_id != @focus['id'] 
          walk(@nodes[edge_id], rels.tail)
        end
      end.compact.flatten
    end
    
    def profiles(nodes)
      client.get_profile(nodes.collect { |node| node['id'].split('-').last })
    end
  end
end