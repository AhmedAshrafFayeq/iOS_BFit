//
//  ExerciseViewModelTest.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 31/07/2022.
//

import XCTest
import RxSwift
import RxCocoa
import Factory
@testable import BFit

import XCTest

class ExerciseViewModelTest: XCTestCase {
    
    var exerciseViewModel: ExerciseViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Container.shared.exerciseAPI.register { MockExercsieAPI() }
        Container.shared.exerciseImageAPI.register { MockExerciseImageAPI() }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        exerciseViewModel = nil
    }

    func testExerciseWithImageCombination() {
        //First API for Exercises
        exerciseViewModel?.getExerciseData(completion: { [weak self] isSuccess in
            
            XCTAssertNil(self?.exerciseViewModel?.homeModelList.first?.exercise)
            XCTAssertNil(self?.exerciseViewModel?.homeModelList.first?.image)
            
            //Second API for Images
            self?.exerciseViewModel?.getExerciseImages(completion: { [weak self] isSucess in
                
                XCTAssertNil(self?.exerciseViewModel?.homeModelList.first?.exercise)
                XCTAssertNil(self?.exerciseViewModel?.homeModelList.first?.image)
                
                // listen to change in (Exercise and Image) using combine method
                self?.exerciseViewModel?.combineExerciseData()
                XCTAssertNotNil(self?.exerciseViewModel?.homeModelList.first?.exercise)
                XCTAssertNotNil(self?.exerciseViewModel?.homeModelList.first?.image)
                
                XCTAssertEqual(self?.exerciseViewModel?.homeModelList[2].exercise.name, "Axe Hold")
                XCTAssertEqual(self?.exerciseViewModel?.homeModelList[2].image.image, "https://wger.de/media/exercise-images/128/Hyperextensions-1.png")
            })
        })
    }
}
