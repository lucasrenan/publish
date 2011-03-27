require File.expand_path("../../../test_helper", __FILE__)

class PostTest < ActiveSupport::TestCase
  
  setup do
    @post = Factory.create(:post)
  end
  
  test "should create published at field" do
    assert      @post.respond_to?(:published_at)
    assert_nil  @post.published_at
  end
  
  test "should create published field" do
    assert        @post.respond_to?(:published)
    assert_equal  @post.published?, false
  end
  
  test "should change unpublished post to published" do
    @post.published = true
    @post.save
    
    assert_not_nil  @post.published_at
    assert_equal    @post.published?, true
    assert_equal    @post.published_at, Date.today
  end
  
  test "should return published posts" do
    2.times { Factory.create(:post, :published => true) }
  
    assert_equal Post.published.size, 2
  end

end