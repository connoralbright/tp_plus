module TPPlus
  module Nodes
    class EvalNode
      def initialize(string)
        @string = string
      end

      def eval(context)
        @string
      end
    end
  end
end
