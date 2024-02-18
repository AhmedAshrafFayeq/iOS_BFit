//
//  ExerciseInfoAPITest.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 31/07/2022.
//

import XCTest
import RxSwift
import RxCocoa
import Factory
@testable import BFit

class ExerciseInfoAPITest: XCTestCase {
    
    var exerciseDetailViewModel: ExerciseDetailViewModel?
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Container.shared.exerciceInfo.register {MockExerciseInfoAPI()}
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        exerciseDetailViewModel = nil
    }
    
    // Test Image Observable when data changing
    func testGetExerciseInfo() {
        exerciseDetailViewModel?.getExerciseInfoData(completion: { [weak self] isSuccess in
            let images = self?.exerciseDetailViewModel?.exerciseImages
            
            XCTAssertNotNil(self?.exerciseDetailViewModel?.exerciseImages)
            XCTAssertNil(images?.first)
        })
    }
}
