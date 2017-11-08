//
//  ReTweetView.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

class ReTweetView: UIView
{
  
  // MARK: - Instance variables
  private var tweet: ReTweet?
  private var bannerDownloadTask: URLSessionDownloadTask?
  private var profilePictureDownloadTask: URLSessionDownloadTask?
  
  // MARK: - Connectors
  @IBOutlet weak var bannerImageView: UIImageView!
  @IBOutlet weak var profilePictureImageView: UIImageView!
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var authorScreenNameLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var hashtagListLabel: UILabel!
  
  // MARK: - Helper functions
  func setContent(optTweet: ReTweet?)
  {
    self.tweet = optTweet
    guard let tweet = self.tweet else { return }
    self.hashtagListLabel.text = ""
    
    self.tweetTextLabel.text = tweet.text
    self.authorNameLabel.text = tweet.originalUser.authorName
    self.authorScreenNameLabel.text = "@\(tweet.originalUser.screenName)"
    self.retweetLabel.text = "@\(tweet.user.screenName) retweeted"
    self.dateLabel.text = formatDate(date: tweet.creationDate, dateFormat: "dd/MM/yyyy hh:mm")
    self.retweetCountLabel.text = String(tweet.retweetCount)
    for hashtag in tweet.hashtag
    {
      self.hashtagListLabel.text?.append("#\(hashtag) ")
    }
    if let profileImageURL = tweet.originalUser.profileImageURL
    {
      profilePictureDownloadTask =
        self.profilePictureImageView.loadImage(url: profileImageURL)
      self.profilePictureImageView.asCircle()
    }
    if let bannerImageURL = tweet.originalUser.profileBannerURL
    {
      bannerDownloadTask =
        self.bannerImageView.loadImage(url: bannerImageURL)
    }
  }
  
}
