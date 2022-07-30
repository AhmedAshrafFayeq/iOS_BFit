//
//  Bundle+UnitTest.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 30/07/2022.
//

import Foundation

extension Bundle {
    public class var unitTest: Bundle{
        return Bundle(for: ExerciseAPITest.self)
    }
}
