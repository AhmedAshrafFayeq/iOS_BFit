//
//  ExercisesAPI.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import Alamofire


// protocol oriented
protocol ExercisesAPIProtocol {
    func getExcerciseData(completion: @escaping (Swift.Result<ExerciseResponse?, AFError>)-> Void)
}

class ExercisesAPI: BaseApi<ExercisesNetworking>, ExercisesAPIProtocol{
    // MARK: - Requests
    
    func getExcerciseData(completion: @escaping (Swift.Result<ExerciseResponse?, AFError>)-> Void) {
        self.fetchData(target: .getExercisesData, responseClass: ExerciseResponse.self) { (result) in
            completion(result)
        }
    }
}
