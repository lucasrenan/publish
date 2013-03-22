require File.expand_path("../../../test_helper", __FILE__)

class PublishTest < ActiveSupport::TestCase

  setup do
    @post = create(:post, :published => false)
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

  test "should list posts excluding drafts" do
    3.times { create(:post, :published => true) }
    create(:post, :published => false)

    assert_equal 3, Post.list(false).count
  end

  test "should list posts including drafts" do
    4.times { create(:post, :published => true) }
    create(:post, :published => false)

    assert_equal 6, Post.list(true).count
  end
end