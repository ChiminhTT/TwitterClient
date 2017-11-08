//
//  BasicCell.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

class BasicTweetCell: UITableViewCell
{
  
  // MARK: - Instance variables
  private var tweet: BasicTweet?
  private var downloadTask: URLSessionDownloadTask?
  
  // MARK: - Connectors
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var authorIconImage: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  
  // MARK: - Override functions
  override func awakeFromNib()
  {
    super.awakeFromNib()
    // Change Selection Color
    let selectedView = UIView()
    selectedView.backgroundColor = UIColor(named: "MaastrichtBlue")
    selectedBackgroundView = selectedView
  }
  
  override func prepareForReuse()
  {
    super.prepareForReuse()
    downloadTask?.cancel()
    downloadTask = nil
  }
  
  // MARK: - Helper functions
  func setCellContent(optTweet: BasicTweet?)
  {
    self.tweet = optTweet
    guard let tweet = self.tweet else { return }
    
    self.tweetTextLabel.text = tweet.text
    self.authorNameLabel.text = tweet.user.authorName
    self.screenNameLabel.text = "@\(tweet.user.screenName)"
    self.retweetCountLabel.text = String(tweet.retweetCount)
    if let profileImageURL = tweet.user.profileImageURL
    {
      downloadTask = self.authorIconImage.loadImage(url: profileImageURL)
      self.authorIconImage.asCircle()
    }
  }
  
}
