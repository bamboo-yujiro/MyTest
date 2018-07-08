//
//  Router.swift
//  MyTest
//
//  Created by Yujiro Takeyama on 2018/07/07.
//  Copyright © 2018年 Yujiro Takeyama. All rights reserved.
//

import Alamofire

class Router {

    static let baseURL = "http://localhost:3000"

    static var articles: URLRequest {
        var urlRequest = URLRequest(url: URL(string: "\(Router.baseURL)/articles")!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        return urlRequest
    }
}
