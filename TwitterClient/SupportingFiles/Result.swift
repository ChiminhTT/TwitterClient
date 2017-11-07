//
//  Result.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

enum Result<T, U> {
  case Ok(T)
  case Err(U)
}

enum Expected<U> {
  case Ok
  case Err(U)
}
