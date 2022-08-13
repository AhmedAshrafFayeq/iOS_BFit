//
//  ExerciseImageAPI.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import Alamofire


// protocol oriented
protocol ExerciseImageAPIProtocol {
    func getExcerciseImageData(completion: @escaping (Swift.Result<ExcerciseImagesResponse?, APIError>)-> Void)
}

class ExerciseImageAPI: BaseApi<ExerciseImageNetworking>, ExerciseImageAPIProtocol{
    // MARK: - Requests
    func getExcerciseImageData(completion: @escaping (Swift.Result<ExcerciseImagesResponse?, APIError>)-> Void) {
        self.fetchData(target: .getExerciseImageData, responseClass: ExcerciseImagesResponse.self) { (result) in
            completion(result)
        }
    }
}
