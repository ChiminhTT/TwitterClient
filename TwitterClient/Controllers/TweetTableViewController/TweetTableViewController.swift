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
        for tweet in self.model.tweets
        {
          print(tweet)
          print("================")
        }
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
  
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 0
  }
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
  {
    return 0
  }
  
}

// MARK: - Navigation
extension TweetTableViewController
{
  
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)
   {
   }
 
}
