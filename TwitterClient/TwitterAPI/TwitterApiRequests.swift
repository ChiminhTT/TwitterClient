//
//  TwitterApiRequests.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import Alamofire
import SwiftyJSON

func requestOAuthAccessToken(
  completionHandler: @escaping (Result<OAuthAccessToken, Error>) -> ())
{
  let getTokenURL =
    TwitterApiConstants.apiURL + TwitterApiEndpoints.oauthEndpoint
  let tokenHeaders: HTTPHeaders = [
    "Authorization": "Basic " + TwitterApiConstants.accessTokenAuthorizationHeader,
  ]
  let tokenParams = ["grant_type": "client_credentials"]
  Alamofire
    .request(getTokenURL,
             method: .post,
             parameters: tokenParams,
             headers: tokenHeaders)
    .validate()
    .responseJSON { response in
      switch response.result
      {
      case .success:
        if let data = response.data
        {
          do
          {
            let json = try JSON(data: data)
            if let accessToken = json["access_token"].string
            {
              completionHandler(.Ok(OAuthAccessToken(value: accessToken)))
            }
            else
            {
              completionHandler(.Err(json["access_token"].error!))
            }
          }
          catch let error
          {
            completionHandler(.Err(error))
          }
        }
      case .failure(let error):
        completionHandler(.Err(error))
      }
  }
}

func requestTweets(
  from authorName: String,
  count: Int,
  tweetMode: String,
  with accessToken: OAuthAccessToken,
  completionHandler: @escaping (Result<[Tweet], Error>) -> ())
{
  let getHeaders: HTTPHeaders = [
    "Authorization": "Bearer " + accessToken.value,
  ]
  let searchQuery = buildSearchQuery(.ScreenName(authorName),
                                     .And,
                                     .Count(count),
                                     .And,
                                     .TweetMode(tweetMode))
  
  Alamofire
    .request(TwitterApiEndpoints.searchQueryEndpoint + searchQuery,
             headers: getHeaders)
    .validate()
    .responseJSON { response in
      switch response.result
      {
      case .success:
        do
        {
          let tweets = builsTweets(from: try JSON(data: response.data!))
          completionHandler(.Ok(tweets))
        }
        catch let error
        {
          completionHandler(.Err(error))
        }
      case .failure(let error):
        completionHandler(.Err(error))
      }
  }
}

fileprivate func builsTweets(from json: JSON) -> [Tweet]
{
  var ret: [Tweet] = []
  for (_, subJson): (String, JSON) in json
  {
    if subJson["retweeted_status"].exists()  // Retweet
    {
      ret.append(ReTweet(json: subJson))
    }
    else if subJson["in_reply_to_status_id"].stringValue != "" // Reply
    {
      ret.append(ReplyTweet(json: subJson))
    }
    else // Basic tweet
    {
      ret.append(BasicTweet(json: subJson))
    }
  }
  return ret
}
