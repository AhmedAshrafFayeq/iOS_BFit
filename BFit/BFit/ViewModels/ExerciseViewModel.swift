//
//  ExerciseViewModel.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import Foundation

protocol ExerciseViewModelProtocol {
    func getExerciseData()
}

class ExerciseViewModel {
    
    //MARK: - Variables
    var exerciseAPI: ExercisesAPIProtocol?
    
    //MARK: - Methods
    init() {
        exerciseAPI = ExercisesAPI()
    }
}

//MARK: - Extention for ExerciseViewModelProtocol
extension ExerciseViewModel: ExerciseViewModelProtocol {
    func getExerciseData() {
        exerciseAPI?.getExcerciseData { (result) in
            switch result{
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
