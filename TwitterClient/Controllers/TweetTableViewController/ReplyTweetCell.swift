//
//  ReplyTweetCell.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

class ReplyTweetCell: UITableViewCell
{
  
  // MARK: - Instance variables
  private var tweet: ReplyTweet?
  private var downloadTask: URLSessionDownloadTask?
  
  // MARK: - Connectors
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var authorIconImage: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var replyLabel: UILabel!
  
  
  // MARK: - Override functions
  override init(style: UITableViewCellStyle, reuseIdentifier: String?)
  {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)!
  }
  
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
  func setCellContent(optTweet: ReplyTweet?)
  {
    self.tweet = optTweet
    guard let tweet = self.tweet else { return }
    
    self.tweetTextLabel.text = tweet.text
    self.authorNameLabel.text =  tweet.user.authorName
    self.screenNameLabel.text = "@\(tweet.user.screenName)"
    self.retweetCountLabel.text = String(tweet.retweetCount)
    self.replyLabel.text = "Replying to @\(tweet.interlocutorScreenName)"
    if let profileImageURL = tweet.user.profileImageURL
    {
      downloadTask = self.authorIconImage.loadImage(url: profileImageURL)
      self.authorIconImage.asCircle()
    }
  }
  
}
