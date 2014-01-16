require 'test_helper'

class TestInterpreter < Test::Unit::TestCase
  include TPPlus::Nodes

  def setup
    @scanner = TPPlus::Scanner.new
    @parser  = TPPlus::Parser.new @scanner
    @interpreter = @parser.interpreter
  end

  def parse(s)
    @scanner.scan_setup(s)
    @parser.parse
  end

  def last_node
    @last_node ||= @interpreter.nodes.last
  end

  def assert_node_type(t, n)
    assert_equal t, n.class
  end

  def assert_prog(s)
    assert_equal s, @interpreter.eval
  end

  def test_blank_prog
    parse("")
    assert_prog ""
  end

  def test_definition
    parse("foo := R[1]")
    assert_prog ""
  end

  def test_multi_define_fails
    parse("foo := R[1]\nfoo := R[2]")
    assert_raise(RuntimeError) do
      assert_prog ""
    end
  end

  def test_var_usage
    parse("foo := R[1]\nfoo = 1")
    assert_prog "R[1:foo]=1 ;\n"
  end

  def test_basic_addition
    parse("foo := R[1]\nfoo = 1 + 1")
    assert_prog "R[1:foo]=1+1 ;\n"
  end

  def test_basic_addition_with_var
    parse("foo := R[1]\n foo = foo + 1")
    assert_prog "R[1:foo]=R[1:foo]+1 ;\n"
  end

  def test_label_definition
    parse("@foo")
    assert_prog "LBL[100:foo] ;\n"
  end

  def test_duplicate_label_definition
    parse("@foo\n@foo")
    assert_raise RuntimeError do
      assert_prog ""
    end
  end

  def test_jump_to_label
    parse("@foo\njump_to @foo")
    assert_prog "LBL[100:foo] ;\nJMP LBL[100:foo] ;\n"
  end

  def test_nonexistent_label_error
    parse("jump_to @foo")
    assert_raise RuntimeError do
      assert_prog ""
    end
  end

  def test_turn_on
    parse("foo := DO[1]\nturn_on foo")
    assert_prog "DO[1:foo]=ON ;\n"
  end

  def test_turn_off
    parse("foo := DO[1]\nturn_off foo")
    assert_prog "DO[1:foo]=OFF ;\n"
  end

  def test_toggle
    parse("foo := DO[1]\ntoggle foo")
    assert_prog "DO[1:foo]=(!DO[1:foo]) ;\n"
  end

  def test_simple_linear_motion
    parse("foo := PR[1]\nlinear_move.to(foo).at(2000mm/s).term(0)")
    assert_prog "L PR[1:foo] 2000mm/sec CNT0 ;\n"
  end

  def test_simple_if
    parse("foo := R[1]\nif foo==1\nfoo=2\nend")
    assert_prog "IF (R[1:foo]=1),R[1:foo]=(2) ;\n"
  end

  def test_simple_if_else
    parse("foo := R[1]\nif foo==1\nfoo=2\nelse\nfoo=1\nend")
    assert_prog "IF R[1:foo]<>1,JMP LBL[100] ;\nR[1:foo]=2 ;\nJMP LBL[101] ;\nLBL[100] ;\nR[1:foo]=1 ;\nLBL[101] ;\n"
  end

  def test_simple_unless
    parse("foo := R[1]\nunless foo==1\nfoo=2\nend")
    assert_prog "IF (R[1:foo]<>1),R[1:foo]=(2) ;\n"
  end

  def test_simple_unless_else
    parse("foo := R[1]\nunless foo==1\nfoo=2\nelse\nfoo=1\nend")
    assert_prog "IF R[1:foo]=1,JMP LBL[100] ;\nR[1:foo]=2 ;\nJMP LBL[101] ;\nLBL[100] ;\nR[1:foo]=1 ;\nLBL[101] ;\n"
  end

  def test_comment
    parse("# this is a comment")
    assert_prog "! this is a comment ;\n"
  end

  def test_two_comments
    parse("# comment one\n# comment two")
    assert_prog "! comment one ;\n! comment two ;\n"
  end

  def test_inline_comment
    parse("foo := R[1] # comment\nfoo = 1 # another comment")
    assert_prog "! comment ;\nR[1:foo]=1 ;\n! another comment ;\n"
  end

  def test_inline_conditional_if_on_jump
    parse("foo := R[1]\n@bar\njump_to @bar if foo==1\n")
    assert_prog "LBL[100:bar] ;\nIF R[1:foo]=1,JMP LBL[100:bar] ;\n"
  end

  def test_inline_conditional_unless_on_jump
    parse("foo := R[1]\n@bar\njump_to @bar unless foo==1\n")
    assert_prog "LBL[100:bar] ;\nIF R[1:foo]<>1,JMP LBL[100:bar] ;\n"
  end

  def test_inline_assignment
    parse("foo := R[1]\nfoo=2 if foo==1\n")
    assert_prog "IF (R[1:foo]=1),R[1:foo]=(2) ;\n"
  end

  def test_inline_io_method
    parse("foo := DO[1]\nbar := R[1]\nturn_on foo if bar < 10\n")
   assert_prog "IF (R[1:bar]<10),DO[1:foo]=(ON) ;\n" 
  end

  def test_program_call
    parse("foo()")
    assert_prog "CALL FOO ;\n"
  end

  def test_program_call_with_simple_arg
    parse("foo(1)")
    assert_prog "CALL FOO(1) ;\n"
  end

  def test_program_call_with_multiple_simple_args
    parse("foo(1,2,3)")
    assert_prog "CALL FOO(1,2,3) ;\n"
  end

  def test_program_call_with_variable_argument
    parse("foo := R[1]\nbar(foo)")
    assert_prog "CALL BAR(R[1:foo]) ;\n"
  end

  def test_preserve_whitespace
    parse("\n\n")
    assert_prog " ;\n"
  end

  def test_plus_equals
    parse("foo := R[1]\nfoo += 1\n")
    assert_prog "R[1:foo]=R[1:foo]+1 ;\n"
  end

  def test_minus_equals
    parse("foo := R[1]\nfoo -= 1\n")
    assert_prog "R[1:foo]=R[1:foo]-1 ;\n"
  end

  def test_motion_to_a_position
    parse("foo := P[1]\nlinear_move.to(foo).at(2000mm/s).term(0)")
    assert_prog "L P[1:foo] 2000mm/sec CNT0 ;\n"
  end

  def test_joint_move
    parse("foo := P[1]\njoint_move.to(foo).at(100%).term(0)")
    assert_prog "J P[1:foo] 100% CNT0 ;\n"
  end

  def test_joint_move_throws_error_with_bad_units
    parse("foo := P[1]\njoint_move.to(foo).at(2000mm/s).term(0)")
    assert_raise(RuntimeError) do
      assert_prog "J P[1:foo] 100% CNT0 ;\n"
    end
  end

  def test_linear_move_throws_error_with_bad_units
    parse("foo := P[1]\nlinear_move.to(foo).at(100%).term(0)")
    assert_raise(RuntimeError) do
      assert_prog "L P[1:foo] 100% CNT0 ;\n"
    end
  end


  def test_pr_offset
    parse("home := P[1]\nmy_offset := PR[1]\nlinear_move.to(home).at(2000mm/s).term(0).offset(my_offset)")
    assert_prog "L P[1:home] 2000mm/sec CNT0 Offset,PR[1:my_offset] ;\n"
  end

  def test_vr_offset
    parse("home := P[1]\nvision_offset := VR[1]\nlinear_move.to(home).at(2000mm/s).term(0).offset(vision_offset)")
    assert_prog "L P[1:home] 2000mm/sec CNT0 VOFFSET,VR[1:vision_offset] ;\n"
  end

  def test_time_before
    parse("p := P[1]\nlinear_move.to(p).at(2000mm/s).term(0).time_before(0.5, foo())")
    assert_prog "L P[1:p] 2000mm/sec CNT0 TB .50sec,CALL FOO ;\n"
  end

  def test_time_after
    parse("p := P[1]\nlinear_move.to(p).at(2000mm/s).term(0).time_after(0.5, foo())")
    assert_prog "L P[1:p] 2000mm/sec CNT0 TA .50sec,CALL FOO ;\n"
  end

  def test_time_before_with_register_time
    parse("p := P[1]\nt := R[1]\nlinear_move.to(p).at(2000mm/s).term(0).time_before(t, foo())")
    assert_prog "L P[1:p] 2000mm/sec CNT0 TB R[1:t]sec,CALL FOO ;\n"
  end

  def test_time_before_with_io_method
    parse("p := P[1]\nbar := DO[1]\nlinear_move.to(p).at(2000mm/s).term(0).time_before(0.5, turn_on bar)")
    assert_prog "L P[1:p] 2000mm/sec CNT0 TB .50sec,DO[1:bar]=ON ;\n"
  end

  def test_motion_with_indirect_termination
    parse("p := P[1]\ncnt := R[1]\nlinear_move.to(p).at(2000mm/s).term(cnt)")
    assert_prog "L P[1:p] 2000mm/sec CNT R[1:cnt] ;\n"
  end

  def test_motion_with_indirect_speed
    parse("p := P[1]\nspeed := R[1]\nlinear_move.to(p).at(speed, mm/s).term(0)")
    assert_prog "L P[1:p] R[1:speed]mm/sec CNT0 ;\n"
  end

  def test_motion_with_max_speed
    parse("p := P[1]\nlinear_move.to(p).at(max_speed).term(0)")
    assert_prog "L P[1:p] max_speed CNT0 ;\n"
  end

  def test_use_uframe
    parse("use_uframe 5")
    assert_prog "UFRAME_NUM=5 ;\n"
  end

  def test_indirect_uframe
    parse("foo := R[1]\nuse_uframe foo")
    assert_prog "UFRAME_NUM=R[1:foo] ;\n"
  end

  def test_use_utool
    parse("use_utool 5")
    assert_prog "UTOOL_NUM=5 ;\n"
  end

  def test_indirect_utool
    parse("foo := R[1]\nuse_utool foo")
    assert_prog "UTOOL_NUM=R[1:foo] ;\n"
  end

  def test_payload
    parse("use_payload 1")
    assert_prog "PAYLOAD[1] ;\n"
  end

  def test_indirect_payload
    parse("foo := R[1]\nuse_payload foo")
    assert_prog "PAYLOAD[R[1:foo]] ;\n"
  end

  def test_nested_conditionals
    parse("foo := R[1]\nif foo==1\nif foo==2\nfoo=3\nelse\nfoo=4\nend\nend")
    assert_prog "IF R[1:foo]<>1,JMP LBL[100] ;\nIF R[1:foo]<>2,JMP LBL[101] ;\nR[1:foo]=3 ;\nJMP LBL[102] ;\nLBL[101] ;\nR[1:foo]=4 ;\nLBL[102] ;\nLBL[100] ;\n"
  end

  def test_inline_unless
    parse("foo := R[1]\n@bar\njump_to @bar unless foo > 1")
    assert_prog "LBL[100:bar] ;\nIF R[1:foo]<=1,JMP LBL[100:bar] ;\n"
  end

  def test_inline_unless_with_two_vars
    parse("foo := R[1]\nbar := R[2]\n@baz\njump_to @baz unless foo > bar")
    assert_prog "LBL[100:baz] ;\nIF R[1:foo]<=R[2:bar],JMP LBL[100:baz] ;\n"
  end

  def test_labels_can_be_defined_after_jumps_to_them
    parse("jump_to @foo\n@foo")
    assert_prog "JMP LBL[100:foo] ;\nLBL[100:foo] ;\n"
  end

  def test_multiple_motion_modifiers
    parse("p := P[1]\no := PR[1]\nlinear_move.to(p).at(max_speed).term(0).offset(o).time_before(0.5,foo())")
    assert_prog "L P[1:p] max_speed CNT0 Offset,PR[1:o] TB .50sec,CALL FOO ;\n"
  end

  def test_motion_modifiers_swallow_terminators_after_dots
    parse("p := P[1]\no := PR[1]\nlinear_move.\nto(p).\nat(max_speed).\nterm(0).\noffset(o).\ntime_before(0.5,foo())")
    assert_prog "L P[1:p] max_speed CNT0 Offset,PR[1:o] TB .50sec,CALL FOO ;\n"
  end

  def test_wait_for_with_seconds
    parse("wait_for 5s")
    assert_prog "WAIT 5.00(sec) ;\n"
  end

  def test_wait_for_with_invalid_units_throws_error
    parse("wait_for 5ns")
    assert_raise(RuntimeError) do
      assert_prog ""
    end
  end

  def test_wait_for_with_milliseconds
    parse("wait_for 100ms")
    assert_prog "WAIT .10(sec) ;\n"
  end

  def test_wait_until_with_exp
    parse("wait_until 1==0")
    assert_prog "WAIT (1=0) ;\n"
  end

  def test_pr_components
    parse("foo := PR[1]\nfoo.x=5\nfoo.y=6\nfoo.z=7\nfoo.w=8\nfoo.p=9\nfoo.r=10\n")
    assert_prog "PR[1,1:foo]=5 ;\nPR[1,2:foo]=6 ;\nPR[1,3:foo]=7 ;\nPR[1,4:foo]=8 ;\nPR[1,5:foo]=9 ;\nPR[1,6:foo]=10 ;\n"
  end

  def test_pr_with_invalid_component_raises_error
    parse("foo := PR[1]\nfoo.bar=5\n")
    assert_raise(RuntimeError) do
      assert_prog ""
    end
  end

  def test_simple_case_statement
    parse("foo := R[1]\ncase foo\nwhen 1\njump_to @asdf\nend\n@asdf")
    assert_prog %(SELECT R[1:foo]=1,JMP LBL[100:asdf] ;\nLBL[100:asdf] ;\n)
  end

  def test_simple_case_with_else_statement
    parse("foo := R[1]\ncase foo\nwhen 1\njump_to @asdf\nelse\njump_to @ghjk\nend\n@asdf\n@ghjk")
    assert_prog %(SELECT R[1:foo]=1,JMP LBL[100:asdf] ;
       ELSE,JMP LBL[101:ghjk] ;
LBL[100:asdf] ;
LBL[101:ghjk] ;\n)
  end

  def test_case_statement_with_two_whens
    parse("foo := R[1]\ncase foo\nwhen 1\njump_to @asdf\nwhen 2\njump_to @ghjk\nend\n@asdf\n@ghjk")
    assert_prog %(SELECT R[1:foo]=1,JMP LBL[100:asdf] ;
       =2,JMP LBL[101:ghjk] ;
LBL[100:asdf] ;
LBL[101:ghjk] ;\n)
  end

  def test_can_use_simple_io_value_as_condition
    parse("foo := UI[5]\n@top\njump_to @top if foo")
    assert_prog "LBL[100:top] ;\nIF (UI[5:foo]),JMP LBL[100:top] ;\n"
  end

  def test_can_use_simple_io_value_as_condition_with_unless
    parse("foo := UI[5]\n@top\njump_to @top unless foo")
    assert_prog "LBL[100:top] ;\nIF (!UI[5:foo]),JMP LBL[100:top] ;\n"
  end

  def test_inline_program_call
    parse("foo := UI[5]\nbar() unless foo")
    assert_prog "IF (!UI[5:foo]),CALL BAR ;\n"
  end

  def test_constant_definition
    parse("FOO := 5\nfoo := R[1]\nfoo = FOO")
    assert_prog "R[1:foo]=5 ;\n"
  end

  def test_constant_definition_real
    parse("PI := 3.14159\nfoo:= R[1]\nfoo = PI")
    assert_prog "R[1:foo]=3.14 ;\n"
  end

  def test_redefining_const_throws_error
    assert_raise(RuntimeError) do
      parse("PI := 3.14\nPI := 5")
      assert_prog ""
    end
  end

  def test_defining_const_without_caps_raises_error
    parse("pi := 3.14")
    assert_raise(RuntimeError) do
      assert_prog ""
    end
  end

  def test_using_argument_var
    parse("foo := AR[1]\n@top\njump_to @top if foo==1")
    assert_prog "LBL[100:top] ;\nIF (AR[1:foo]=1),JMP LBL[100:top] ;\n"
  end

  def test_use_uframe_with_constant
    parse("FOO := 1\nuse_uframe FOO")
    assert_prog "UFRAME_NUM=1 ;\n"
  end

  def test_fanuc_set_uframe_with_pr
    parse("foo := PR[1]\nset_uframe 5, foo")
    assert_prog "UFRAME[5]=PR[1:foo] ;\n"
  end

  def test_fanuc_set_uframe_with_constant
    parse("foo := PR[1]\nBAR := 5\nset_uframe BAR, foo")
    assert_prog "UFRAME[5]=PR[1:foo] ;\n"
  end

  def test_fanuc_set_uframe_with_reg
    parse("foo := PR[1]\nbar := R[1]\nset_uframe bar, foo")
    assert_prog "UFRAME[R[1:bar]]=PR[1:foo] ;\n"
  end

  def test_set_skip_condition
    parse("foo := RI[1]\nset_skip_condition foo.on?")
    assert_prog "SKIP CONDITION RI[1:foo]=ON ;\n"
  end

  def test_skip_to
    parse("p := P[1]\n@somewhere\nlinear_move.to(p).at(2000mm/s).term(0).skip_to(@somewhere)")
    assert_prog "LBL[100:somewhere] ;\nL P[1:p] 2000mm/sec CNT0 Skip,LBL[100:somewhere] ;\n"
  end

  def test_skip_to_with_pr
    parse("p := P[1]\nlpos := PR[1]\n@somewhere\nlinear_move.to(p).at(2000mm/s).term(0).skip_to(@somewhere, lpos)")
    assert_prog "LBL[100:somewhere] ;\nL P[1:p] 2000mm/sec CNT0 Skip,LBL[100:somewhere],PR[1:lpos]=LPOS ;\n"
  end
end
