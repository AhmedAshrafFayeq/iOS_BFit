//
//  ExerciseDetailViewModel.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Factory

protocol ExerciseDetailViewModelProtocol {
    var exerciseInfoBehaviorSubject: BehaviorSubject<[Image]> { get }
    func getExerciseInfoData(completion : @escaping (Bool)-> Void)
}

class ExerciseDetailViewModel: BaseViewModel {
    //MARK: - Variables
    var exerciseImages = [Image]()
    @Injected(\.exerciceInfo) var exerciseInfoAPI
    
}

//MARK: - Extention for ExerciseDetailViewModelProtocol
extension ExerciseDetailViewModel: ExerciseDetailViewModelProtocol {
    var exerciseInfoBehaviorSubject: BehaviorSubject<[Image]> {
        return BehaviorSubject(value: exerciseImages)
    }
    
    func getExerciseInfoData(completion: @escaping (Bool) -> Void) {
        exerciseInfoAPI.getExcerciseInfoData(completion: { (result) in
            switch result{
            case .success(let response):
                
                self.exerciseImages = response?.results.first?.images ?? []
                self.exerciseInfoBehaviorSubject.on(.next(response?.results.first?.images ?? []))
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        })
    }
}
