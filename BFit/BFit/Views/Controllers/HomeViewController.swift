//
//  HomeViewController.swift
//  BFit
//
//  Created by Ahmed Fayeq on 25/07/2022.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Token 0031f15438ad2993cf4d6c176be01a9852dab94c"
        ]

        AF.request("https://wger.de/api/v2/login/?format=json", headers: headers).responseJSON { response in
           //Parse or print your response.
            print(response)
        }
    }
    
}
