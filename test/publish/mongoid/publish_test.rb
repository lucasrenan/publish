require File.expand_path("../../../test_helper", __FILE__)

class PublishTest < ActiveSupport::TestCase

  setup do
    @post = create(:post)
  end

  test "should create published at field" do
    assert      @post.respond_to?(:published_at)
    assert_nil  @post.published_at
  end

  test "should create published field" do
    assert        @post.respond_to?(:published)
    assert_equal  @post.published?, false
  end

  test "should be unpublished if published at is not setted" do
    post = build(:post)
    post.published = true

    assert_equal post.published?, false
  end

  test "should change unpublished post to published" do
    @post.published = true
    @post.save

    assert_not_nil  @post.published_at
    assert_equal    @post.published?, true
    assert_equal    @post.published_at, Date.today
  end

  test "should return published posts" do
    2.times { create(:post, :published => true) }

    assert_equal Post.published.size, 2
  end

  test "should return orderly published posts" do
    create(:post, :title => "2", :published => true, :published_at => 1.month.ago)
    create(:post, :title => "3", :published => true, :published_at => 1.year.ago)
    create(:post, :title => "1", :published => true, :published_at => 1.day.ago)

    assert_equal Post.published_and_orderly.map(&:title), ["1", "2", "3"]
  end

  test "should publish a post" do
    post = build(:post)
    post.publish!
    post.reload

    assert post.published?
    assert_equal Post.published.size, 1
  end
  
  test "should concat with criteria methods" do
    create(:post, :published => true, :title => "normal post")
    create(:post, :published => true, :title => "my special post")
    
    assert_equal Post.where(:title => /special/).published.count, 1
    assert_equal Post.published.where(:title => /special/).count, 1
  end
  
  test "should return publication status as draft if is not published yet" do
    assert_equal Post.last.publication_status, "draft"
  end
  
  test "should return published at date if is published" do
    @post.publish!
    
    assert_equal Post.last.publication_status, Date.today
  end

end