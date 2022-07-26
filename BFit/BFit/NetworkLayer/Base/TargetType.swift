//
//  TargetType.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

//wrapper for the params of the request method
enum Task {
    case requestPlain   //without params
    case requestParmeters(parameters: [String: Any], encoding: ParameterEncoding)
}

//wrapper for api call
protocol TargetType {
    var baseURL: String {get}
    var path: String {get}  //after baseUrl
    var method: HTTPMethod {get}
    var task: Task {get}
    var headers: [String: String]? {get}
}

