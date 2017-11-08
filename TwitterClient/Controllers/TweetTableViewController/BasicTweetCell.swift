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
  func setCellContent(optTweet: BasicTweet?)
  {
    self.tweet = optTweet
    guard let tweet = self.tweet else { return }
    self.tweetTextLabel.text = tweet.text
    self.authorNameLabel.text = "@" + tweet.authorName
    self.retweetCountLabel.text = String(tweet.retweetCount)
    if let profileImageURL = tweet.profileImageURL
    {
      downloadTask = self.authorIconImage.loadImage(url: profileImageURL)
      transformImageToCircle(on: self.authorIconImage)
    }
  }
  
  func transformImageToCircle(on imageView: UIImageView)
  {
    imageView.layer.borderWidth = 0.5
    imageView.layer.masksToBounds = false
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.layer.cornerRadius = self.authorIconImage.frame.height/2
    imageView.clipsToBounds = true
  }
}
