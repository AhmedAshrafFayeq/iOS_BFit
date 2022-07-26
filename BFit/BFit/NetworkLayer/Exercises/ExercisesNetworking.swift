//
//  ExercisesNetworking.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import Alamofire

enum ExercisesNetworking {
    case getExercisesData
}

extension ExercisesNetworking: TargetType{
    var baseURL: String {
        get {
            return ServerConstants.baseServer
        }
        set {}
    }

    var path: String {
        switch self {
        case .getExercisesData:
            return "exercise\(ServerConstants.language)\(ServerConstants.getLanguage())\(ServerConstants.format)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getExercisesData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getExercisesData:
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
