module TPPlus
  module Nodes
    class NamespaceNode
      attr_reader :block
      def initialize(name, block)
        @name = name
        @block = block
      end

      def eval(context)
        context.add_namespace(@name, @block)
        nil
      end
    end
  end
end
