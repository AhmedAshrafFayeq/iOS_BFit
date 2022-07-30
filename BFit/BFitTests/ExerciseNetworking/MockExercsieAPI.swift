//
//  MockExercsieAPI.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 30/07/2022.
//

import Foundation
import Alamofire

class MockExercsieAPI: ExercisesAPIProtocol {
    
    func getExcerciseData(completion: @escaping (Swift.Result<ExerciseResponse?, AFError>)-> Void) {
        
        guard let bundlePath =  Bundle.unitTest.path(forResource: "ExerciseAPIMock", ofType: "json") else {
            return
        }
        do {
            if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(ExerciseResponse.self,
                                                           from: jsonData)
                completion(.success( decodedData))
            }
        }catch {
            
        }
    }
    
}
