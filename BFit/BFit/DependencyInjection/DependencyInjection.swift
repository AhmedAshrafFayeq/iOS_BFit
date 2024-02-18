//
//  DependencyInjection.swift
//  BFit
//
//  Created by Ahmed Fayek on 17/02/2024.
//

import Factory

extension Container {
    var exerciceInfo: Factory <ExerciseInfoAPIProtocol> {
        Factory(self) {ExerciseInfoAPI()}
    }
    var exerciseAPI: Factory <ExercisesAPIProtocol> {
        Factory(self) {ExercisesAPI()}
    }
    var exerciseImageAPI: Factory<ExerciseImageAPIProtocol> {
        Factory(self) {ExerciseImageAPI()}
    }
            
}

