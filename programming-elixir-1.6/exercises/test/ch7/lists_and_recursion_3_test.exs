defmodule MyList.Exercise3.Test do
  use ExUnit.Case, async: true

  describe "Test MyList.Exercise3.caesar" do
    test "should return 'elixir'" do
      expected_output = MyList.Exercise3.caesar('ryvkve', 13)
      assert expected_output === 'elixir'
    end

    test "should return '' if the given single quoted string is empty" do
      expected_output = MyList.Exercise3.caesar('', 13)
      assert expected_output === ''
    end
  end
end
