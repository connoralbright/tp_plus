module TPPlus
  module Nodes
    class PositionNode
      attr_accessor :comment
      def initialize(id)
        @id = id
        @comment = ""
      end

      def comment_string
        return "" if @comment == ""

        ":#{@comment}"
      end

      def eval(context)
        "P[#{@id}#{comment_string}]"
      end
    end
  end
end