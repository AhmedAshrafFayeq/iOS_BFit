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
    var exerciseCombineBehaviourSubject: BehaviorSubject<[HomeModel]> {get}
    
    func getExerciseData(completion : @escaping (Bool)-> Void)
    func getExerciseImages(completion : @escaping (Bool)-> Void)
    func combineExerciseData()
}

class ExerciseViewModel: BaseViewModel {
    
    //MARK: - Variables
    var images = [Image]()
    var exercises = [Exercise]()
    var exerciseAPI: ExercisesAPIProtocol?
    var exerciseImageAPI: ExerciseImageAPIProtocol?
    var homeModelList = [HomeModel]()
    
    //MARK: - Initializer
    init(exerciseAPI: ExercisesAPIProtocol = ExercisesAPI(), exerciseImageAPI: ExerciseImageAPIProtocol = ExerciseImageAPI()) {
        super.init()
        self.exerciseAPI = exerciseAPI
        self.exerciseImageAPI = exerciseImageAPI
        combineExerciseData()
    }
}

//MARK: - Extention for ExerciseViewModelProtocol
extension ExerciseViewModel: ExerciseViewModelProtocol {
    
    var exerciseCombineBehaviourSubject: BehaviorSubject<[HomeModel]> {
        return BehaviorSubject(value: self.homeModelList)
    }
    
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
                self.images = response?.results ?? []
                self.exerciseImageBehaviorSubject.on(.next(response?.results ?? []))
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        })
    }
    
    func combineExerciseData() {
        var exercisesVariation = [HomeModel]()
        Observable.combineLatest(exerciseBehaviorSubject, exerciseImageBehaviorSubject).map { exercises, images in
            let homeModelSortedList = zip(exercises, images).sorted(by: { $0.0.exerciseBase == $1.0.exerciseBase })
            for (exercise, image) in  homeModelSortedList {
                for v in exercise.variations {
                    for (ex, im) in homeModelSortedList {
                        if ex.id == v && exercise.id != v {
                            exercisesVariation.append(HomeModel(exercise: ex, image: im, vaiations: exercisesVariation))
                        }
                    }
                }
                self.homeModelList.append(HomeModel(exercise: exercise, image: image, vaiations: exercisesVariation))
                exercisesVariation.removeAll()
            }
            return self.homeModelList
        }.bind(to: exerciseCombineBehaviourSubject).disposed(by: disposeBag)
        
    }
}
