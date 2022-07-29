//
//  ExerciseInfoNetworking.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import Foundation
import Alamofire

enum ExerciseInfoNetworking {
    case getExerciseInfoData
}

extension ExerciseInfoNetworking: TargetType{
    var baseURL: String {
        get {
            return "https://wger.de/api/v2/"
        }
        set {}
    }

    var path: String {
        switch self {
        case .getExerciseInfoData:
            return "exerciseinfo/?format=json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getExerciseInfoData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getExerciseInfoData:
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
