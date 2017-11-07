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
  var authorName: String { get }
  var text: String { get }
  var creationDate: Date { get }
  var retweetCount: Int { get }
  var profileBannerURL: URL? { get }
  var profileImageURL : URL? {get}
  var hashtag: [Hashtag] { get }
  
  init(json: JSON)
}


struct BasicTweet: Tweet
{
  let authorName: String
  let text: String
  let creationDate: Date
  let retweetCount: Int
  let profileBannerURL: URL?
  let profileImageURL: URL?
  let hashtag: [Hashtag]
}
extension BasicTweet
{
  init(json: JSON)
  {
    self.authorName =
      json["user"]["name"].stringValue
    self.text =
      json["text"].string ?? json["full_text"].stringValue
    self.creationDate =
      getDate(isoDate: json["created_at"].stringValue)
    self.retweetCount =
      json["retweet_count"].intValue
    self.profileBannerURL =
      URL(string: json["user"]["profile_banner_url"].stringValue)
    self.profileImageURL =
      URL(string: json["user"]["profile_image_url_https"].stringValue)
    self.hashtag =
      getHashtags(json: json["entities"]["hashtags"])
  }
}


struct ReTweet: Tweet
{
  let authorName: String
  let text: String
  let creationDate: Date
  let retweetCount: Int
  let profileBannerURL: URL?
  let profileImageURL: URL?
  let hashtag: [Hashtag]
  
  let originalUserName: String
}
extension ReTweet
{
  init(json: JSON)
  {
    self.authorName =
      json["user"]["name"].stringValue
    self.text =
      json["retweeted_status"]["text"].string
      ?? json["retweeted_status"]["full_text"].stringValue
    self.creationDate =
      getDate(isoDate: json["created_at"].stringValue)
    self.retweetCount =
      json["retweet_count"].intValue
    self.profileBannerURL =
      URL(string: json["user"]["profile_banner_url"].stringValue)
    self.profileImageURL =
      URL(string: json["user"]["profile_image_url_https"].stringValue)
    self.hashtag =
      getHashtags(json: json["entities"]["hashtags"])
    
    self.originalUserName =
      json["retweeted_status"]["user"]["name"].stringValue
  }
}


struct ReplyTweet: Tweet
{
  let authorName: String
  let text: String
  let creationDate: Date
  let retweetCount: Int
  let profileBannerURL: URL?
  let profileImageURL: URL?
  let hashtag: [Hashtag]
  
  let interlocutorName: String
}
extension ReplyTweet
{
  init(json: JSON)
  {
    self.authorName =
      json["user"]["name"].stringValue
    self.text =
      json["text"].string ?? json["full_text"].stringValue
    self.creationDate =
      getDate(isoDate: json["created_at"].stringValue)
    self.retweetCount =
      json["retweet_count"].intValue
    self.profileBannerURL =
      URL(string: json["user"]["profile_banner_url"].stringValue)
    self.profileImageURL =
      URL(string: json["user"]["profile_image_url_https"].stringValue)
    self.hashtag =
      getHashtags(json: json["entities"]["hashtags"])
    
    self.interlocutorName =
      json["in_reply_to_screen_name"].stringValue
  }
}

// MARK: - Helper functions
func getDate(isoDate: String) -> Date
{
  let dateFormatter = DateFormatter()
  // Twitter date format - Thu Apr 06 15:24:15 +0000 2017
  dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
  let date = dateFormatter.date(from: isoDate)!
  return date
}

func getHashtags(json: JSON) -> [Hashtag]
{
  var ret : [Hashtag] = []
  for (_, subJson): (String, JSON) in json
  {
    let hashtag = Hashtag(describing: subJson["text"])
    ret.append(hashtag)
  }
  return ret
}
