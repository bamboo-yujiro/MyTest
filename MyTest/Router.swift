//
//  Router.swift
//  MyTest
//
//  Created by Yujiro Takeyama on 2018/07/07.
//  Copyright © 2018年 Yujiro Takeyama. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {

    static let baseURL = "http://localhost:3000"

    case articles

    var method: Alamofire.HTTPMethod {
        switch self {
        case .articles:
            return .get
        }
    }

    var path: String {
        switch self {
        case .articles:
            return "/articles"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Router.baseURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .articles:
            return try Alamofire.JSONEncoding.default.encode(urlRequest)
        }
    }

}
