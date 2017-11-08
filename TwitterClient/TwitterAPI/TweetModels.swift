//
//  TweetModels.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias Hashtag = String

protocol Tweet: Codable
{
  var text: String { get }
  var creationDate: Date { get }
  var retweetCount: Int { get }
  var user: TwitterUser { get }
  var hashtag: [Hashtag] { get }
  
  init(json: JSON)
}


struct BasicTweet: Tweet
{
  let text: String
  let creationDate: Date
  let retweetCount: Int
  let user: TwitterUser
  let hashtag: [Hashtag]
}
extension BasicTweet
{
  init(json: JSON)
  {
    self.text =
      json["text"].string ?? json["full_text"].stringValue
    self.creationDate =
      getDate(isoDate: json["created_at"].stringValue)
    self.retweetCount =
      json["retweet_count"].intValue
    self.user =
      TwitterUser(from: json["user"])
    self.hashtag =
      getHashtags(json: json["entities"]["hashtags"])
  }
}


struct ReTweet: Tweet
{
  let text: String
  let creationDate: Date
  let retweetCount: Int
  let user: TwitterUser
  let hashtag: [Hashtag]
  
  let originalUser: TwitterUser
}
extension ReTweet
{
  init(json: JSON)
  {
    self.text =
      json["retweeted_status"]["text"].string
      ?? json["retweeted_status"]["full_text"].stringValue
    self.creationDate =
      getDate(isoDate: json["created_at"].stringValue)
    self.retweetCount =
      json["retweet_count"].intValue
    self.user =
      TwitterUser(from: json["user"])
    self.hashtag =
      getHashtags(json: json["entities"]["hashtags"])
    
    self.originalUser =
      TwitterUser(from: json["retweeted_status"]["user"])
  }
}


struct ReplyTweet: Tweet
{
  let text: String
  let creationDate: Date
  let retweetCount: Int
  let user: TwitterUser
  let hashtag: [Hashtag]
  
  let interlocutorScreenName: String
}
extension ReplyTweet
{
  init(json: JSON)
  {
    self.text =
      json["text"].string ?? json["full_text"].stringValue
    self.creationDate =
      getDate(isoDate: json["created_at"].stringValue)
    self.retweetCount =
      json["retweet_count"].intValue
    self.user =
      TwitterUser(from: json["user"])
    self.hashtag =
      getHashtags(json: json["entities"]["hashtags"])
    
    self.interlocutorScreenName =
      json["in_reply_to_screen_name"].stringValue
  }
}

// MARK: - Helper functions
fileprivate func getDate(isoDate: String) -> Date
{
  let dateFormatter = DateFormatter()
  // Twitter date format - Thu Apr 06 15:24:15 +0000 2017
  dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
  let date = dateFormatter.date(from: isoDate)!
  return date
}

fileprivate func getHashtags(json: JSON) -> [Hashtag]
{
  var ret : [Hashtag] = []
  for (_, subJson): (String, JSON) in json
  {
    let hashtag = Hashtag(describing: subJson["text"])
    ret.append(hashtag)
  }
  return ret
}

// MARK: - Format functions
func formatDate(date: Date, dateFormat: String) -> String
{
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = dateFormat
  return dateFormatter.string(from: date)
}
