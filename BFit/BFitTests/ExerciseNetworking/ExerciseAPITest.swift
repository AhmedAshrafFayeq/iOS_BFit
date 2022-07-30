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
    
    
    func testGetExercise() {
        let promise = XCTestExpectation(description: "Fetch Data Completed")
        exerciseViewModel?.getExerciseData(completion: { isSuccess in
            print("Sub B, line: \(#line)", "event: \(self.exerciseViewModel?.exercises)")
            
        })
        promise.fulfill()
        self.wait(for: [promise], timeout: 1)
    }

}
