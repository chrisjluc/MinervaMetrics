require! 'chai':{assert, expect}
analytics = require '../analytics/message_count'

describe 'analytics/message_count' ->
  dateObj = year:2016 month: 10 day:1 hour:2
  countObj1 = year:2016 month: 10 day:1 hour:2 count:9
  countObj2 = year:2016 month: 10 day:1 hour:5 count:5

  specify 'postProcessMessageCountResults testEmpty' ->
    results = analytics.postProcessMessageCountResults([], 'hour')
    expect results.length .to.equal 0

  specify 'postProcessMessageCountResults testSingle' ->
    results = analytics.postProcessMessageCountResults([countObj1], 'hour')
    expect results.length .to.equal 1
    expect results[0].count .to.equal 9
    expect results[0].timestamp .to.equal (new Date 2016, 10, 1, 2).getTime!

  specify 'postProcessMessageCountResults testFills' ->
    results = analytics.postProcessMessageCountResults([countObj1, countObj2], 'hour')
    expect results.length .to.equal 4
    expect results[0].count .to.equal 9
    expect results[0].timestamp .to.equal (new Date 2016, 10, 1, 2).getTime!

    expect results[1].count .to.equal 0
    expect results[1].timestamp .to.equal (new Date 2016, 10, 1, 3).getTime!

    expect results[3].count .to.equal 5
    expect results[3].timestamp .to.equal (new Date 2016, 10, 1, 5).getTime!

  specify 'incrementPeriod hour' ->
    result = analytics.incrementPeriod (new Date 2000, 10, 10, 10), 'hour'
    expect result.getTime! .to.equal (new Date 2000, 10, 10, 11).getTime!

  specify 'incrementPeriod day' ->
    result = analytics.incrementPeriod (new Date 2000, 10, 10), 'day'
    expect result.getTime! .to.equal (new Date 2000, 10, 11).getTime!

  specify 'incrementPeriod month' ->
    result = analytics.incrementPeriod (new Date 2000, 12, 1), 'month'
    expect result.getTime! .to.equal (new Date 2001, 1, 1).getTime!

  specify 'convertDateToObjToJSDate' ->
    result = analytics.convertDateObjToJSDate dateObj
    expect result.getTime! .to.equal (new Date 2016, 10, 1, 2).getTime!
