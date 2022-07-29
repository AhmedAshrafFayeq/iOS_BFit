//
//  ExerciseInfoAPI.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import Foundation
import Alamofire


// protocol oriented
protocol ExerciseInfoAPIProtocol {
    func getExcerciseInfoData(completion: @escaping (Swift.Result<ExerciseInfoResponse?, AFError>)-> Void)
}

class ExerciseInfoAPI: BaseApi<ExerciseInfoNetworking>, ExerciseInfoAPIProtocol{
    // MARK: - Requests
    
    func getExcerciseInfoData(completion: @escaping (Swift.Result<ExerciseInfoResponse?, AFError>)-> Void) {
        self.fetchData(target: .getExerciseInfoData, responseClass: ExerciseInfoResponse.self) { (result) in
            completion(result)
        }
    }
}
