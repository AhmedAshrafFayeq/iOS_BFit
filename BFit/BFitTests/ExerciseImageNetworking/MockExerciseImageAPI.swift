//
//  MockExerciseImageAPI.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 31/07/2022.
//

import Foundation
import Alamofire

class MockExerciseImageAPI: ExerciseImageAPIProtocol {
    
    func getExcerciseImageData(completion: @escaping (Result<ExcerciseImagesResponse?, AFError>) -> Void) {
        guard let bundlePath =  Bundle.unitTest.path(forResource: "ImageAPIMock", ofType: "json") else {
            return
        }
        do {
            if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(ExcerciseImagesResponse.self,
                                                           from: jsonData)
                completion(.success( decodedData))
            }
        }catch {
            
        }
    }
}
