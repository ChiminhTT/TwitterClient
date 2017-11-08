//
//  ReplyTweetView.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

class ReplyTweetView: UIView
{
  
  // MARK: - Instance variables
  private var tweet: ReplyTweet?
  private var bannerDownloadTask: URLSessionDownloadTask?
  private var profilePictureDownloadTask: URLSessionDownloadTask?
  
  // MARK: - Connectors
  @IBOutlet weak var bannerImageView: UIImageView!
  @IBOutlet weak var profilePictureImageView: UIImageView!
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var authorScreenNameLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var replyLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var hashtagListLabel: UILabel!
  
  // MARK: - Helper functions
  func setContent(optTweet: ReplyTweet?)
  {
    self.tweet = optTweet
    guard let tweet = self.tweet else { return }
    self.hashtagListLabel.text = ""
    
    self.tweetTextLabel.text = tweet.text
    self.authorNameLabel.text = tweet.user.authorName
    self.authorScreenNameLabel.text = "@\(tweet.user.screenName)"
    self.dateLabel.text = formatDate(date: tweet.creationDate, dateFormat: "dd/MM/yyyy hh:mm")
    self.retweetCountLabel.text = String(tweet.retweetCount)
    self.replyLabel.text = "Replying to @\(tweet.interlocutorScreenName)"
    for hashtag in tweet.hashtag
    {
      self.hashtagListLabel.text?.append("#\(hashtag) ")
    }
    if let profileImageURL = tweet.user.profileImageURL
    {
      profilePictureDownloadTask =
        self.profilePictureImageView.loadImage(url: profileImageURL)
      self.profilePictureImageView.asCircle()
    }
    if let bannerImageURL = tweet.user.profileBannerURL
    {
      bannerDownloadTask =
        self.bannerImageView.loadImage(url: bannerImageURL)
    }
  }
  
}

