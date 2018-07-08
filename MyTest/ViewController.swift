//
//  ViewController.swift
//  MyTest
//
//  Created by Yujiro Takeyama on 2018/06/30.
//  Copyright © 2018年 Yujiro Takeyama. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class ViewController: UIViewController {

/*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var urlRequest = URLRequest(url: URL(string: "http://localhost:3000")!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        Alamofire.request(Router.articles)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success:
                    print("Success!")
                case .failure:
                    print("Failure!")
                }
        }
    }
 */

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("View Did Load")


        self.getArticles().subscribe(onCompleted: {
        }, onError: { error in
            print(error)
        }).disposed(by: self.disposeBag)
    }

    private func getArticles() -> Completable {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

