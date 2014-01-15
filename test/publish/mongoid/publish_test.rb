require File.expand_path("../../../test_helper", __FILE__)

class PublishTest < ActiveSupport::TestCase

  setup do
    @post = create(:post, :published => false)
  end

  test "should create published at field" do
    assert     @post.respond_to?(:published_at)
    assert_nil @post.published_at
  end

  test "should create published field" do
    assert       @post.respond_to?(:published)
    assert_equal @post.published?, false
  end

  test "should be not published if published_at is not setted" do
    post           = build(:post)
    post.published = true

    assert_equal false, post.published?
  end

  test "should publish setting published field manually" do
    @post.published = true

    Timecop.freeze do
      @post.save

      assert       @post.published?
      assert_equal @post.published_at, Time.now
    end
  end

  test "should publish a post calling publish! method" do
    post = build(:post)
    post.publish!
    post.reload

    assert       post.published?
    assert_equal 1, Post.published.count
  end

  test "should return publication status as 'draft' if it's not published yet" do
    assert_equal "draft", Post.last.publication_status
  end

  test "should sets published at time automatically after publish" do
    Timecop.freeze do
      @post.publish!
      assert_equal @post.publication_status, Time.now
    end
  end

  test "should sets published at with just date" do
    @post.published_at = Date.today
    @post.save

    assert_equal Date.today, @post.published_at.to_date
  end

  test "should list published posts" do
    2.times { create(:post, :published => true) }

    assert_equal Post.published.size, 2
  end

  test "should concat with criteria methods" do
    create(:post, :published => true, :title => "normal post")
    create(:post, :published => true, :title => "my special post")

    assert_equal 1, Post.where(:title => /special/).published.count
    assert_equal 1, Post.published.where(:title => /special/).count
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

  test "should unpublish a post calling unpublish! method" do
    post = create(:post, published: true, published_at: Time.now)
    post.unpublish!

    assert_equal post.published?, false
    assert_equal post.published_at, nil
  end

  test "should publish all posts" do
    2.times { create(:post) }
    Post.publish_all!

    assert_equal 3, Post.published.count
    assert_equal 0, Post.unpublished.count
  end

  test "should unpublish all posts" do
    2.times { create(:post, published: true, published_at: Time.now) }
    Post.unpublish_all!

    assert_equal 0, Post.published.count
    assert_equal 3, Post.unpublished.count
  end

end
