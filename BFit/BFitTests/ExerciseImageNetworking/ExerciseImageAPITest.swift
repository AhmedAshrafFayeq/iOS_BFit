//
//  ExerciseImageAPITest.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 31/07/2022.
//

import XCTest
import RxSwift
import RxCocoa
@testable import BFit

class ExerciseImageAPITest: XCTestCase {
    
    var exerciseViewModel: ExerciseViewModel?
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        exerciseViewModel = ExerciseViewModel(exerciseImageAPI: MockExerciseImageAPI())
    }

    override func tearDownWithError() throws {
        exerciseViewModel = nil
    }

    // Test Image Observable when data changing
    func testGetExercise() {
        exerciseViewModel?.getExerciseImages(completion: { [weak self] isSucess in
            XCTAssertNotNil(self?.exerciseViewModel?.images)
            
            let images = self?.exerciseViewModel?.images
            //first objct
            XCTAssertEqual(images?.first?.image, "https://wger.de/media/exercise-images/91/Crunches-1.png")
            if let isMain = images?.first?.isMain {
                XCTAssertTrue(isMain)
            }
            XCTAssertNotEqual(images?.last?.image, "https://wger.de/media/exercise-images/62/Barbell-upright-rows-2.png")
            
            //last objct
            XCTAssertNotEqual(images?.last?.image, "https://wger.de/media/exercise-images/91/Crunches-1.png")
            XCTAssertEqual(images?.last?.image, "https://wger.de/media/exercise-images/181/Chin-ups-2.png")
            
            if let isMain = images?.last?.isMain {
                XCTAssertTrue(isMain)
            }
        })
    }
}
