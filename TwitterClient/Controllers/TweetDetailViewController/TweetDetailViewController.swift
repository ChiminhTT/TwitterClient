//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit
import MessageUI

class TweetDetailViewController: UIViewController
{

  // MARK: - Instance variables
  var model = TweetDetailViewModel()
  
  // MARK: - Connectors
  @IBAction func sendSMS(_ sender: Any)
  {
    guard let tweet = model.tweet else { return }
    guard MFMessageComposeViewController.canSendText() else
    {
      let alert = buildMsgNotAvailableErrorAlert()
      self.displayAlert(alert: alert)
      return
    }
    
    let dateStr =
      formatDate(date: tweet.creationDate, dateFormat: "dd-MM-YYYY")
    
    let messageVC = MFMessageComposeViewController()
    messageVC.body =
      "Le \(dateStr), \(tweet.user.authorName) a tweeté: «\(tweet.text)»";
    messageVC.recipients = []
    messageVC.messageComposeDelegate = self;
    
    self.present(
      messageVC,
      animated: true,
      completion: nil
    )
  }
  
  // MARK: - Controller Lifecyle functions
  override func viewDidLoad()
  {
    super.viewDidLoad()
    // View should be below navigationBar
    self.edgesForExtendedLayout = []
  }

}

// MARK: - MFMessage Delegate and affiliated
extension TweetDetailViewController: MFMessageComposeViewControllerDelegate
{
  
  func displayAlert(alert: UIAlertController)
  {
    DispatchQueue.main.async { self.present(alert, animated: true) }
  }
  
  func messageComposeViewController(
    _ controller: MFMessageComposeViewController,
    didFinishWith result: MessageComposeResult)
  {
    switch (result)
    {
    case .cancelled: // Do nothing
      self.dismiss(animated: true, completion: nil)
    case .failed: // Display error alert
      let alert = buildMsgSentErrorAlert()
      self.dismiss(animated: true, completion: nil)
      self.displayAlert(alert: alert)
    case .sent: // Display success alert
      let alert = buildMsgSentSuccessAlert()
      self.dismiss(animated: true, completion: nil)
      self.displayAlert(alert: alert)
    }
  }
  
}

// MARK: - Helper member Function
extension TweetDetailViewController
{
  
  func addTweetView(from tweet: Tweet)
  {
    if let reTweet = tweet as? ReTweet
    {
      let tweetView =
        Bundle.main.loadNibNamed(
          "ReTweetView",
          owner: self,
          options: nil
        )!.first as! ReTweetView // This should not fail
      tweetView.setContent(optTweet: reTweet)
      self.view = tweetView
    }
    else if let replyTweet = tweet as? ReplyTweet
    {
      let tweetView =
        Bundle.main.loadNibNamed(
          "ReplyTweetView",
          owner: self,
          options: nil
        )!.first as! ReplyTweetView // This should not fail
      tweetView.setContent(optTweet: replyTweet)
      self.view = tweetView
    }
    else // BasicTweet
    {
      let tweetView =
        Bundle.main.loadNibNamed(
          "BasicTweetView",
          owner: self,
          options: nil
        )!.first as! BasicTweetView // This should not fail
      tweetView.setContent(optTweet: tweet as? BasicTweet)
      self.view = tweetView
    }
  }
  
}
