//
//  ExerciseImageNetworking.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import Alamofire

enum ExerciseImageNetworking {
    case getExerciseImageData
}

extension ExerciseImageNetworking: TargetType{
    var baseURL: String {
        get {
            return ServerConstants.baseServer
        }
        set {}
    }

    var path: String {
        switch self {
        case .getExerciseImageData:
            return "exerciseimage\(ServerConstants.language)\(ServerConstants.getLanguage())\(ServerConstants.format)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getExerciseImageData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getExerciseImageData:
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
