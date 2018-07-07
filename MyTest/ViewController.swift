//
//  ViewController.swift
//  MyTest
//
//  Created by Yujiro Takeyama on 2018/06/30.
//  Copyright © 2018年 Yujiro Takeyama. All rights reserved.
//

import UIKit
import Alamofire
import vfrReader

class ViewController: UIViewController, ReaderViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

