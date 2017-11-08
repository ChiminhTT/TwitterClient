//
//  TweetTableViewController.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

struct Parameters
{
  static let authorName = "@BanquePopulaire"
  static let tweetCount = 10
  static let tweetMode = "extended"
}

struct TableViewCellIdentifiers
{
  static let basicTweetCell = "BasicTweetCell"
  static let reTweetCell = "ReTweetCell"
  static let replyTweetCell = "ReplyTweetCell"
}

let basicTweetCellNib =
  UINib(nibName: TableViewCellIdentifiers.basicTweetCell,
        bundle: nil)
let reTweetCellNib =
  UINib(nibName: TableViewCellIdentifiers.reTweetCell,
        bundle: nil)
let replyTweetCellNib =
  UINib(nibName: TableViewCellIdentifiers.replyTweetCell,
        bundle: nil)

func initializeTableView(on vc: TweetTableViewController)
{
  // Setup cell auto resizing
  vc.tableView.rowHeight = UITableViewAutomaticDimension
  vc.tableView.estimatedRowHeight = 100
  // Register cells
  vc.tableView.register(basicTweetCellNib,
                        forCellReuseIdentifier: TableViewCellIdentifiers.basicTweetCell)
  vc.tableView.register(reTweetCellNib,
                        forCellReuseIdentifier: TableViewCellIdentifiers.reTweetCell)
  vc.tableView.register(replyTweetCellNib,
                        forCellReuseIdentifier: TableViewCellIdentifiers.replyTweetCell)
  // Remove empty cells at table footer
  vc.tableView.tableFooterView = UIView()
}

class TweetTableViewController: UITableViewController
{

  // MARK: - Instance variablea
  var model = TweetTableViewModel(
    accessToken: OAuthAccessToken(value: ""),
    tweets: []
  )
  
  // MARK: - Connectors
  @IBAction func refreshTweets(_ sender: Any)
  {
    self.fetchTweets(
      from: Parameters.authorName,
      count: Parameters.tweetCount,
      tweetMode: Parameters.tweetMode
    )
  }
  
  // MARK: - Controller life cycle functions
  override func viewDidLoad()
  {
    super.viewDidLoad()

    initializeTableView(on: self)
    self.fetchTweets(
      from: Parameters.authorName,
      count: Parameters.tweetCount,
      tweetMode: Parameters.tweetMode
    )
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
}

// MARK: - Fetch Model Functions
extension TweetTableViewController
{
  
  func fetchTweets(from authorName: String, count: Int, tweetMode: String)
  {
    requestTweets(
      from: authorName,
      count: count,
      tweetMode: tweetMode,
      with: self.model.accessToken
    ) { resp in
      switch resp
      {
      case .Ok(let tweets):
        self.model.tweets = tweets
        DispatchQueue.main.async { self.tableView.reloadData() }
      case .Err(_):
        self.displayNetworkErrorAlert()
      }
    }
  }
  
  func displayNetworkErrorAlert()
  {
    DispatchQueue.main.async
    {
        self.present(
          buildAlertNetworkError(actionLabel: "Ok", actionHandler: {}),
          animated: true
        )
    }
  }
  
}

// MARK: - TableView related functions
extension TweetTableViewController
{
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
  {
    return self.model.tweets.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let tweet = self.model.tweets[indexPath.row]
    if tweet is ReTweet
    {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: TableViewCellIdentifiers.reTweetCell,
        for: indexPath
      ) as! ReTweetCell
      cell.setCellContent(optTweet: (tweet as! ReTweet))
      return cell
    }
    else if tweet is ReplyTweet
    {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: TableViewCellIdentifiers.replyTweetCell,
        for: indexPath
      ) as! ReplyTweetCell
      cell.setCellContent(optTweet: (tweet as! ReplyTweet))
      return cell
    }
    else // Basic Tweet
    {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: TableViewCellIdentifiers.basicTweetCell,
        for: indexPath
      ) as! BasicTweetCell
      cell.setCellContent(optTweet: (tweet as! BasicTweet))
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath)
  {
    tableView.deselectRow(at: indexPath, animated: true)
    self.performSegue(withIdentifier: "tweetDetailSegue", sender: nil)
  }
  
}

// MARK: - Navigation
extension TweetTableViewController
{
  
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)
   {
   }
 
}
