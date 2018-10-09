require 'minitest/autorun'
require 'minitest/pride'
require './lib/interface.rb'

class InterfaceTest < Minitest::Test
  def test_it_exists
    interface = Interface.new
    assert_instance_of Interface, interface
  end
end
