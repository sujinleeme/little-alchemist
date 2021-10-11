defmodule MyList.Exercise4.Test do
  use ExUnit.Case, async: true

  describe "test span() that returns a list of the numbers from 'from(the first param)' up to 'to(the second param)'" do
    test "should return the only one number if both 'from' and 'to' are equal" do
      expected_output = [4]
      assert expected_output === MyList.Exercise4.span(4, 4)
    end

    test "should return an empty list if 'from' is greater than 'to'" do
      expected_output = []
      assert expected_output === MyList.Exercise4.span(4, 3)
    end

    test "returns a list of numbers incremented by 1 from '7' to '8'" do
      expected_output = [7, 8, 9]
      # IO.inspect expected_output, charlists: false
      ## It will print ..........[7, 8, 9]
      assert expected_output === MyList.Exercise4.span(7, 9)
    end

    test "returns 7 elements in a list from '4' to '10'" do
      expected_output = [4, 5, 6, 7, 8, 9, 10]
      actual_output = MyList.Exercise4.span(4, 10)
      assert expected_output === actual_output
      assert Enum.count(actual_output) === Enum.count(expected_output)
    end
  end
end
