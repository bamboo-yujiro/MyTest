//
//  InfraSampleForTest.swift
//  MyTest
//
//  Created by Yujiro Takeyama on 2018/09/08.
//  Copyright © 2018年 Yujiro Takeyama. All rights reserved.
//
import Alamofire
import RxSwift

class InfraSampleForTest {

    func getArticles() -> Completable {
        var urlRequest = URLRequest(url: URL(string: "http://localhost:3000/articles")!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue

        return Completable.create { subscriber in
            Alamofire.request(Router.articles)
                .validate { request, response, data in
                    // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                    return .success
                }
                .responseJSON { response in
                    //debugPrint(response)
                    switch response.result {
                    case .success:
                        return subscriber(.completed)
                    case .failure(let error):
                        return subscriber(.error(error))
                    }
            }
            return Disposables.create()
        }
    }

}
