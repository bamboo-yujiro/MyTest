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
        
        
        let urlString: String = "http://www.pdf995.com/samples/pdf.pdf"
        let destination = DownloadRequest.suggestedDownloadDestination()
        Alamofire.download(urlString, to: destination).validate().responseData { response in
            debugPrint(response)
            guard
                let pdfPath = response.destinationURL?.path,
                let document = ReaderDocument(filePath: pdfPath, password: nil),
                let readerVC = ReaderViewController(readerDocument: document) else {
                return
            }
            readerVC.delegate = self
            readerVC.modalPresentationStyle = .fullScreen
            self.present(readerVC, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

