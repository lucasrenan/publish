require File.expand_path("../../../../test_helper", __FILE__)

class CallbacksTest < ActiveSupport::TestCase

  setup do
    @klass = Product
    @product  = FactoryGirl.build(:product)
  end

  test "should includes the before_publish callback" do
    assert @klass.respond_to?(:before_publish)
  end

  test "should includes the after_publish callback" do
    assert @klass.respond_to?(:after_publish)
  end

  test "should not execute callbacks publish callbacks if not call publish!" do
    assert_nil @product.before_publish_called
    assert_nil @product.after_publish_called
  end

  test "should execute the before_publish and after_publish callbacks" do
    @product.publish!

    assert @product.before_publish_called
    assert @product.after_publish_called
  end

end