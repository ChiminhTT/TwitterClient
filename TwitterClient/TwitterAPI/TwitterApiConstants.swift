//
//  TwitterApiConstants.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

struct TwitterApiConstants
{
  static let apiURL =
    "https://api.twitter.com/"
  // App keys linked to @Noone twitter dev account
  static let consumerKey =
    "q0hkX0WktyDULNFUfDABvDQEF"
  static let consumerSecret =
    "dFJRH1Lf29BgAmZQnK2s0rjpfPHKUMN8gXJumHIoin8gXIYurG"
  static let accessTokenAuthorizationHeader =
    (TwitterApiConstants.consumerKey + ":" + TwitterApiConstants.consumerSecret)
      .toBase64()

}

struct TwitterApiEndpoints
{
  static let oauthEndpoint =
    "/oauth2/token/"
}
