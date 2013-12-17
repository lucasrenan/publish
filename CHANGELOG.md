# Publish Change History

## Next Release

  * TODO

## 0.4.0 - 2013-12-17

  * Tested against rails 4 and mongoid master only

## 0.3.0 - 2013-04-04

  * Changes published_at field type from Date to Time

  * Removes scope `published_and_orderly`

## 0.2.0 - 2013-03-22

  * New method `list` - see README

## 0.1.2 - 2013-03-04

  * Define scopes as lazy to prevent it from using class loading date instead of scope calling date (it will be default in rails 4)

  * Now supports mongoid master

## 0.1.1 - 2012-10-02

  * Callbacks (after_publish, before_publish) (lucas renan) - resolve issue #4

## 0.1.0 - 2012-09-04

  * Now supports only Mongoid 3

## 0.0.6

  * Basic functionality