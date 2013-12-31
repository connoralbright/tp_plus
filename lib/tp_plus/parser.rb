#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.10
# from Racc grammer file "".
#

require 'racc/parser.rb'
module TPPlus
  class Parser < Racc::Parser


  include TPPlus::Nodes

  attr_reader :interpreter
  def initialize(scanner, interpreter = TPPlus::Interpreter.new)
    @scanner       = scanner
    @interpreter   = interpreter
    super()
  end

  def next_token
    t = @scanner.next_token
    @interpreter.line_count += 1 if t == [:NEWLINE,"\n"]

    puts t.inspect
    t
  end

  def parse
    do_parse
    @interpreter
  rescue Racc::ParseError => e
    raise "Parse error on line #{@interpreter.line_count+1}: #{e}"
  end
##### State transition tables begin ###

racc_action_table = [
    16,     5,    10,    63,     9,    53,    54,    15,    16,     5,
    10,    55,     9,    19,    67,    15,    17,    68,    16,     5,
    10,    19,     9,    37,    17,    15,    32,    24,    32,    24,
    42,    38,    39,    13,    17,    70,    14,    57,    58,    59,
    61,    13,    60,    71,    14,    16,     5,    10,    19,     9,
    73,    13,    15,    19,    14,    16,     5,    10,    19,     9,
    40,    17,    15,    16,     5,    10,    36,     9,    19,    73,
    15,    17,    57,    58,    59,    61,    19,    60,    13,    17,
    78,    14,    32,    24,    32,    24,    95,    96,    13,    32,
    24,    14,    32,    24,    32,    24,    13,    32,    24,    14,
    47,    48,    51,    52,    49,    50,    53,    54,    79,    80,
    35,    34,    55,    83,    25,    24,    19,    85,    86,    87,
    88,    89,    90,    91,    93,    20,    93,    98,    99,    32,
    32,   103,   104,   105 ]

racc_action_check = [
     0,     0,     0,    34,     0,    74,    74,     0,    26,    26,
    26,    74,    26,     0,    36,    26,     0,    36,    21,    21,
    21,    26,    21,    18,    26,    21,    13,    13,    70,    70,
    25,    18,    18,     0,    21,    38,     0,    28,    28,    28,
    28,    26,    28,    39,    26,     4,     4,     4,    43,     4,
    44,    21,     4,    22,    21,    73,    73,    73,     4,    73,
    20,     4,    73,    33,    33,    33,    17,    33,    73,    62,
    33,    73,    75,    75,    75,    75,    33,    75,     4,    33,
    63,     4,    45,    45,    37,    37,    93,    93,    73,    71,
    71,    73,    14,    14,    56,    56,    33,    46,    46,    33,
    27,    27,    27,    27,    27,    27,    27,    27,    67,    68,
    16,    15,    27,    72,    10,     9,     2,    77,    78,    79,
    80,    86,    87,    88,    89,     1,    94,    95,    96,    98,
    99,   100,   101,   102 ]

racc_action_pointer = [
    -3,   125,   100,   nil,    42,   nil,   nil,   nil,   nil,    96,
   111,   nil,   nil,     8,    74,   100,    91,    64,     3,   nil,
    60,    15,    37,   nil,   nil,    11,     5,    78,     7,   nil,
   nil,   nil,   nil,    60,    -9,   nil,     8,    66,    15,    23,
   nil,   nil,   nil,    32,    13,    64,    79,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    76,   nil,   nil,   nil,
   nil,   nil,    32,    40,   nil,   nil,   nil,    66,    67,   nil,
    10,    71,    75,    52,   -23,    42,   nil,    79,    99,   101,
   102,   nil,   nil,   nil,   nil,   nil,    80,    79,    80,   113,
   nil,   nil,   nil,    73,   115,    87,    88,   nil,   111,   112,
    90,   111,    92,   nil,   nil,   nil ]

racc_action_default = [
    -1,   -62,    -2,    -3,    -7,   -10,   -11,   -12,   -13,   -62,
   -62,   -16,   -17,   -62,   -62,   -62,   -62,   -33,   -62,   -61,
   -62,    -5,    -6,   -14,   -33,   -62,    -8,   -34,   -36,   -38,
   -54,   -55,   -56,    -8,   -62,   -28,   -62,   -62,   -62,   -62,
   106,    -4,   -15,    -9,   -21,   -62,   -62,   -40,   -41,   -42,
   -43,   -44,   -45,   -46,   -47,   -48,   -62,   -49,   -50,   -51,
   -52,   -53,   -21,   -62,   -29,   -57,   -58,   -62,   -62,   -30,
   -62,   -62,   -62,    -8,   -35,   -37,   -39,   -62,   -62,   -62,
   -62,   -31,   -32,   -18,   -20,   -19,   -62,   -62,   -62,   -62,
   -59,   -60,   -22,   -62,   -24,   -62,   -62,   -23,   -62,   -62,
   -62,   -62,   -62,   -25,   -27,   -26 ]

racc_goto_table = [
    18,    26,    33,    44,    18,    72,    92,    21,     2,    23,
    62,    97,    22,   101,   102,    94,    41,   100,     1,    64,
    74,    18,    45,    77,    75,    69,    18,    21,    76,    65,
    66,   nil,   nil,    18,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    21,   nil,
    84,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    81,    82,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    18 ]

racc_goto_check = [
     9,    12,    12,     5,     9,    13,    14,     4,     2,     9,
     5,    14,     2,    17,    17,    15,     3,    16,     1,    18,
    19,     9,    20,    13,    21,    12,     9,     4,    23,    25,
    26,   nil,   nil,     9,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     4,   nil,
     5,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    12,    12,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     9 ]

racc_goto_pointer = [
   nil,    18,     8,    -5,     5,   -23,   nil,   nil,   nil,     0,
   nil,   nil,   -12,   -39,   -83,   -78,   -81,   -85,   -17,   -25,
    -5,   -22,   nil,   -28,   nil,    -7,    -6 ]

racc_goto_default = [
   nil,   nil,    43,     3,     4,   nil,     6,     7,     8,    31,
    11,    12,   nil,   nil,   nil,   nil,   nil,    30,   nil,    27,
   nil,    28,    46,    29,    56,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 45, :_reduce_none,
  1, 45, :_reduce_2,
  1, 46, :_reduce_3,
  3, 46, :_reduce_4,
  2, 46, :_reduce_5,
  2, 46, :_reduce_none,
  1, 46, :_reduce_7,
  0, 49, :_reduce_none,
  1, 49, :_reduce_9,
  1, 47, :_reduce_10,
  1, 47, :_reduce_11,
  1, 47, :_reduce_12,
  1, 47, :_reduce_13,
  2, 47, :_reduce_14,
  3, 47, :_reduce_15,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  5, 55, :_reduce_18,
  5, 55, :_reduce_19,
  2, 57, :_reduce_20,
  0, 57, :_reduce_none,
  7, 52, :_reduce_22,
  3, 58, :_reduce_none,
  2, 58, :_reduce_none,
  4, 59, :_reduce_none,
  4, 59, :_reduce_none,
  2, 60, :_reduce_none,
  2, 54, :_reduce_28,
  3, 50, :_reduce_29,
  3, 51, :_reduce_30,
  4, 51, :_reduce_31,
  4, 51, :_reduce_32,
  1, 53, :_reduce_33,
  1, 56, :_reduce_34,
  3, 56, :_reduce_35,
  1, 63, :_reduce_36,
  3, 63, :_reduce_37,
  1, 65, :_reduce_none,
  3, 65, :_reduce_39,
  1, 64, :_reduce_none,
  1, 64, :_reduce_none,
  1, 64, :_reduce_none,
  1, 64, :_reduce_none,
  1, 64, :_reduce_none,
  1, 64, :_reduce_none,
  1, 66, :_reduce_none,
  1, 66, :_reduce_none,
  1, 66, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  1, 67, :_reduce_none,
  1, 67, :_reduce_none,
  1, 61, :_reduce_56,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  4, 69, :_reduce_59,
  4, 70, :_reduce_60,
  1, 48, :_reduce_none ]

racc_reduce_n = 62

racc_shift_n = 106

racc_token_table = {
  false => 0,
  :error => 1,
  :ASSIGN => 2,
  :AT_SYM => 3,
  :COMMENT => 4,
  :JUMP => 5,
  :NUMREG => 6,
  :IO_METHOD => 7,
  :INPUT => 8,
  :OUTPUT => 9,
  :MOVE => 10,
  :DOT => 11,
  :TO => 12,
  :AT => 13,
  :TERM => 14,
  :SEMICOLON => 15,
  :NEWLINE => 16,
  :REAL => 17,
  :DIGIT => 18,
  :WORD => 19,
  :EQUAL => 20,
  :UNITS => 21,
  :EEQUAL => 22,
  :NOTEQUAL => 23,
  :GTE => 24,
  :LTE => 25,
  :LT => 26,
  :GT => 27,
  :PLUS => 28,
  :MINUS => 29,
  :STAR => 30,
  :SLASH => 31,
  :DIV => 32,
  :AND => 33,
  :OR => 34,
  :MOD => 35,
  :IF => 36,
  :ELSE => 37,
  :END => 38,
  :UNLESS => 39,
  "(" => 40,
  ")" => 41,
  "[" => 42,
  "]" => 43 }

racc_nt_base = 44

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "ASSIGN",
  "AT_SYM",
  "COMMENT",
  "JUMP",
  "NUMREG",
  "IO_METHOD",
  "INPUT",
  "OUTPUT",
  "MOVE",
  "DOT",
  "TO",
  "AT",
  "TERM",
  "SEMICOLON",
  "NEWLINE",
  "REAL",
  "DIGIT",
  "WORD",
  "EQUAL",
  "UNITS",
  "EEQUAL",
  "NOTEQUAL",
  "GTE",
  "LTE",
  "LT",
  "GT",
  "PLUS",
  "MINUS",
  "STAR",
  "SLASH",
  "DIV",
  "AND",
  "OR",
  "MOD",
  "IF",
  "ELSE",
  "END",
  "UNLESS",
  "\"(\"",
  "\")\"",
  "\"[\"",
  "\"]\"",
  "$start",
  "program",
  "statements",
  "statement",
  "terminator",
  "block",
  "definition",
  "assignment",
  "motion_statement",
  "var",
  "label_definition",
  "conditional",
  "expression",
  "else_block",
  "motion_modifiers",
  "motion_modifier",
  "speed",
  "number",
  "definable",
  "simple_expression",
  "relop",
  "term",
  "addop",
  "factor",
  "mulop",
  "numreg",
  "output" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

def _reduce_2(val, _values, result)
 @interpreter.nodes = val[0] 
    result
end

def _reduce_3(val, _values, result)
 result = val 
    result
end

def _reduce_4(val, _values, result)
 result = val[0] << val[2] 
    result
end

def _reduce_5(val, _values, result)
 result = val[0] 
    result
end

# reduce 6 omitted

def _reduce_7(val, _values, result)
 result = [TerminatorNode.new] 
    result
end

# reduce 8 omitted

def _reduce_9(val, _values, result)
 result = val[0] 
    result
end

def _reduce_10(val, _values, result)
 result = CommentNode.new(val[0]) 
    result
end

def _reduce_11(val, _values, result)
 result = val[0] 
    result
end

def _reduce_12(val, _values, result)
 result = val[0] 
    result
end

def _reduce_13(val, _values, result)
 result = val[0] 
    result
end

def _reduce_14(val, _values, result)
 result = IOMethodNode.new(val[0],val[1]) 
    result
end

def _reduce_15(val, _values, result)
 result = JumpNode.new(val[2]) 
    result
end

# reduce 16 omitted

# reduce 17 omitted

def _reduce_18(val, _values, result)
 result = ConditionalNode.new(val[1],val[2],val[3]) 
    result
end

def _reduce_19(val, _values, result)
 result = ConditionalNode.new(val[1],val[3],val[2]) 
    result
end

def _reduce_20(val, _values, result)
 result = val[1] 
    result
end

# reduce 21 omitted

def _reduce_22(val, _values, result)
 result = MotionNode.new(val[0],val[4],val[6]) 
    result
end

# reduce 23 omitted

# reduce 24 omitted

# reduce 25 omitted

# reduce 26 omitted

# reduce 27 omitted

def _reduce_28(val, _values, result)
 result = LabelDefinitionNode.new(val[1]) 
    result
end

def _reduce_29(val, _values, result)
 result = DefinitionNode.new(val[0],val[2]) 
    result
end

def _reduce_30(val, _values, result)
 result = AssignmentNode.new(val[0],val[2]) 
    result
end

def _reduce_31(val, _values, result)
 result = AssignmentNode.new(
                                           val[0],
                                           ExpressionNode.new(val[0],val[1],val[3])
                                         )
                                       
    result
end

def _reduce_32(val, _values, result)
 result = AssignmentNode.new(
                                           val[0],
                                           ExpressionNode.new(val[0],val[1],val[3])
                                         )
                                       
    result
end

def _reduce_33(val, _values, result)
 result = VarNode.new(val[0]) 
    result
end

def _reduce_34(val, _values, result)
 result = val[0] 
    result
end

def _reduce_35(val, _values, result)
 result = ExpressionNode.new(val[0],val[1],val[2]) 
    result
end

def _reduce_36(val, _values, result)
 result = val[0] 
    result
end

def _reduce_37(val, _values, result)
 result = ExpressionNode.new(val[0],val[1],val[2]) 
    result
end

# reduce 38 omitted

def _reduce_39(val, _values, result)
 result = ExpressionNode.new(val[0],val[1],val[2]) 
    result
end

# reduce 40 omitted

# reduce 41 omitted

# reduce 42 omitted

# reduce 43 omitted

# reduce 44 omitted

# reduce 45 omitted

# reduce 46 omitted

# reduce 47 omitted

# reduce 48 omitted

# reduce 49 omitted

# reduce 50 omitted

# reduce 51 omitted

# reduce 52 omitted

# reduce 53 omitted

# reduce 54 omitted

# reduce 55 omitted

def _reduce_56(val, _values, result)
 result = DigitNode.new(val[0]) 
    result
end

# reduce 57 omitted

# reduce 58 omitted

def _reduce_59(val, _values, result)
 result = NumregNode.new(val[2].to_i) 
    result
end

def _reduce_60(val, _values, result)
 result = IONode.new(val[0], val[2].to_i) 
    result
end

# reduce 61 omitted

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module TPPlus
