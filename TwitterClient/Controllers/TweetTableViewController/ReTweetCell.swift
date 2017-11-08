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
    self.originalAuthorNameLabel.text = "@" + tweet.originalUserName
    self.retweetCountLabel.text = String(tweet.retweetCount)
    self.retweetLabel.text = tweet.originalUserName + " retweeted"
    if let profileImageURL = tweet.originalProfileImageURL
    {
      downloadTask = self.originalAuthorIconImage.loadImage(url: profileImageURL)
      transformImageToCircle(on: self.originalAuthorIconImage)
    }
  }
  
  func transformImageToCircle(on imageView: UIImageView)
  {
    imageView.layer.borderWidth = 0.5
    imageView.layer.masksToBounds = false
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.layer.cornerRadius = self.originalAuthorIconImage.frame.height/2
    imageView.clipsToBounds = true
  }
  
}
