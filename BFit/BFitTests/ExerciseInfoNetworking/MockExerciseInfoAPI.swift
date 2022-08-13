//
//  MockExerciseInfoAPI.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 31/07/2022.
//

import Foundation
import Alamofire

class MockExerciseInfoAPI: ExerciseInfoAPIProtocol {
    func getExcerciseInfoData(completion: @escaping (Result<ExerciseInfoResponse?, APIError>) -> Void) {
        guard let bundlePath =  Bundle.unitTest.path(forResource: "ExerciseInfoAPIMock", ofType: "json") else {
            return
        }
        do {
            if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(ExerciseInfoResponse.self, from: jsonData)
                completion(.success( decodedData))
            }
        }catch {
            
        }
    }
}
