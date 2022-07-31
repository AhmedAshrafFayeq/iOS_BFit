//
//  ExerciseAPITest.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 30/07/2022.
//

import XCTest
import RxSwift
import RxCocoa
@testable import BFit

class ExerciseAPITest: XCTestCase {
    
    var exerciseViewModel: ExerciseViewModel?
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        exerciseViewModel = ExerciseViewModel(exerciseAPI: MockExercsieAPI())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        exerciseViewModel = nil
    }
    
    // Test Exercises Observable when data changing 
    func testGetExercise() {
        exerciseViewModel?.getExerciseData(completion: { [weak self] isSuccess in
            XCTAssertNotNil(self?.exerciseViewModel?.exercises)

            let exercises = self?.exerciseViewModel?.exercises
            //first objct
            XCTAssertEqual(exercises?.first?.name, "2 Handed Kettlebell Swing")
            XCTAssertEqual(exercises?.first?.id, 345)
            //last object
            XCTAssertEqual(exercises?.last?.name, "Biceps Curls With Barbell")
            XCTAssertEqual(exercises?.last?.id, 74)
            XCTAssertEqual(exercises?.last?.variations, [74,81,80,129,275,298,86,138,193,208,205,768,305])
            
        })
    }

}
