//
//  TwitterApiRequests.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import Alamofire
import SwiftyJSON

func requestOAuthAccessToken(
  completionHandler: @escaping (String?, Error?) -> ())
{
  let getTokenURL =
    TwitterApiConstants.apiURL + TwitterApiEndpoints.oauthEndpoint
  let tokenHeaders: HTTPHeaders = [
    "Authorization": "Basic " + TwitterApiConstants.accessTokenAuthorizationHeader,
  ]
  let tokenParams = ["grant_type": "client_credentials"]
  Alamofire
    .request(getTokenURL,
             method: .post,
             parameters: tokenParams,
             headers: tokenHeaders)
    .validate()
    .responseJSON { response in
      switch response.result
      {
      case .success:
        if let data = response.data
        {
          let json = JSON(data: data)
          if let access_token = json["access_token"].string {
            completionHandler(access_token, nil)
          } else {
            print(json["access_token"].error!)
          }
        }
      case .failure(let error):
        completionHandler(nil, error)
      }
  }
}
