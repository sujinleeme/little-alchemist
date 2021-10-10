defmodule MyList.Exercise1.Test do
  use ExUnit.Case, async: true

  describe "Test MyList.Exercise1.mapsum" do
    test "should return 0 if the list is empty" do
      expected_output = MyList.Exercise1.mapsum([], &(&1 + &1))
      assert expected_output === 0
    end

    test "should multiply each element of the list and then sums the result" do
      expected_output = MyList.Exercise1.mapsum([1, 3, 10], &(&1 * &1))
      assert expected_output === 110
    end

    test "should raise FunctionClauseError if any elements of the list are noninteger" do
      assert_raise FunctionClauseError,
                   "no function clause matching in MyList.Exercise1.mapsum/2",
                   fn ->
                     MyList.Exercise1.mapsum([1, "2", 3], &(&1 + &1))
                   end
    end
  end
end
