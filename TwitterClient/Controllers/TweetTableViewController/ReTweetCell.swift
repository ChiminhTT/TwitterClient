//
//  ReTweetCell.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

class ReTweetCell: UITableViewCell
{
  
  // MARK: - Instance variables
  private var tweet: ReTweet?
  private var downloadTask: URLSessionDownloadTask?
  
  // MARK: - Connectors
  @IBOutlet weak var originalAuthorNameLabel: UILabel!
  @IBOutlet weak var originalAuthorIconImage: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var originalScreenNameLabel: UILabel!
  
  
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
  func setCellContent(optTweet: ReTweet?)
  {
    self.tweet = optTweet
    guard let tweet = self.tweet else { return }
    
    self.tweetTextLabel.text = tweet.text
    self.originalAuthorNameLabel.text = tweet.originalUser.authorName
    self.originalScreenNameLabel.text = "@\(tweet.originalUser.screenName)"
    self.retweetCountLabel.text = String(tweet.retweetCount)
    self.retweetLabel.text = "\(tweet.user.authorName) retweeted"
    if let profileImageURL = tweet.originalUser.profileImageURL
    {
      downloadTask = self.originalAuthorIconImage.loadImage(url: profileImageURL)
      self.originalAuthorIconImage.asCircle()
    }
  }
  
}
