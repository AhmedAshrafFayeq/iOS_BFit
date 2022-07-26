//
//  ExercisesNetworking.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import Alamofire

enum ExercisesNetworking {
    case getExcercisesData
}

extension ExercisesNetworking: TargetType{
    var baseURL: String {
        get {
            return "https://wger.de/api/v2/"
        }
        set {}
    }

    var path: String {
        switch self {
        case .getExcercisesData:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getExcercisesData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getExcercisesData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
