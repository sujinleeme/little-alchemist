defmodule Chop.Test do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  describe "High/Low guessing game" do
    test "should raise FunctionClauseError if an actual number type is not integer" do
      assert_raise FunctionClauseError, "no function clause matching in Chop.guess/2", fn ->
        Chop.guess("3", 1..10)
      end
    end

    test "should raise FunctionClauseError if an actual number isn't within a range" do
      assert_raise FunctionClauseError, "no function clause matching in Chop.guess/2", fn ->
        Chop.guess(20, 1..10)
      end
    end

    test "should print guess processing until the guess correct" do
      expected_output = "Is it 10?\nIs it 5?\nIs it 2?\nIs it 3?\n>> Yes, it's 3.\n"
      assert capture_io(fn -> Chop.guess(3, 1..20) end) == expected_output
    end
  end
end
