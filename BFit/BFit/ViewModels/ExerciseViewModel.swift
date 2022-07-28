//
//  ExerciseViewModel.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ExerciseViewModelProtocol {
    
    var exerciseBehaviorSubject: BehaviorSubject<[Exercise]> { get }
    var exerciseImageBehaviorSubject: BehaviorSubject<[Image]> { get }
    
    func getExerciseData(completion : @escaping (Bool)-> Void)
    func getExerciseImages(completion : @escaping (Bool)-> Void)
}

class ExerciseViewModel {
    var exercises = [Exercise]()
    var images = [Image]()
    
    //MARK: - Variables
    var exerciseAPI: ExercisesAPIProtocol?
    var exerciseImageAPI: ExerciseImageAPIProtocol?
    
    //MARK: - Methods
    init() {
        exerciseAPI = ExercisesAPI()
        exerciseImageAPI = ExerciseImageAPI()
    }
}

//MARK: - Extention for ExerciseViewModelProtocol
extension ExerciseViewModel: ExerciseViewModelProtocol {
    
    var exerciseImageBehaviorSubject: BehaviorSubject<[Image]> {
        return BehaviorSubject(value: images)
    }
    var exerciseBehaviorSubject: BehaviorSubject<[Exercise]> {
        return BehaviorSubject(value: exercises)
    }
    
    func getExerciseData(completion : @escaping (Bool)-> Void) {
        exerciseAPI?.getExcerciseData { (result) in
            switch result{
            case .success(let response):
                
                self.exercises = response?.results ?? []
                self.exerciseBehaviorSubject.on(.next(response?.results ?? []))
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func getExerciseImages(completion : @escaping (Bool)-> Void) {
        exerciseImageAPI?.getExcerciseImageData(completion: { (result) in
            switch result{
            case .success(let response):
                print(response)
                
                self.images = response?.results ?? []
                self.exerciseImageBehaviorSubject.on(.next(response?.results ?? []))
              //  self.images = self.exerciseBehaviorSubject.filter{$0.first?.id == self.images.first?.id}
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        })
    }
}
