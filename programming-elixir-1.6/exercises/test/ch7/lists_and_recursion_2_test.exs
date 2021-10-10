defmodule MyList.Exercise2.Test do
  use ExUnit.Case, async: true

  describe "Test MyList.Exercise2.max" do
    test "should return the max value in the given list" do
      expected_output = MyList.Exercise2.max([1, 100, 20])
      assert expected_output === 100
    end

    test "should return the max value of integer in the given list" do
      expected_output = MyList.Exercise2.max([1, "10000", 10, 3])
      assert expected_output === 10
    end

    test "should return unique values from the list if there is no integer value in the given list" do
      expected_output = MyList.Exercise2.max(["ten", "1000", "ten", "100"])
      assert expected_output === ["1000", "ten", "100"]
    end
  end
end
