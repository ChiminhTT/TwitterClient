//
//  SearchQuery.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

typealias SearchQuery = String

func buildSearcQuery(_ queryArgs: QueryArg...) -> SearchQuery
{
  let str = queryArgs.map({ $0.eval() })
                     .reduce("", +)
  return SearchQuery(str)
}

enum QueryArg
{
  case ScreenName(String)
  case Count(Int)
  case TweetMode(String)
  case And
}

extension QueryArg
{
  
  func eval() -> String
  {
    switch self
    {
    case .ScreenName(let name):
      return "screen_name=" + name
    case .Count(let count):
      return "count=" + String(count)
    case .TweetMode(let tweetMode):
      return "tweet_mode=" + tweetMode
    case .And:
      return "&"
    }
  }
  
}
