//
//  ExerciseAPITest.swift
//  BFitTests
//
//  Created by Ahmed Fayeq on 30/07/2022.
//

import XCTest
@testable import BFit

class ExerciseAPITest: XCTestCase {
    
    //create system under test instance of baseAPI
    var exerciseNetworking: BaseApi<ExercisesNetworking>!
    var homeVC: HomeViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        exerciseNetworking = BaseApi()
        homeVC = HomeViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        exerciseNetworking = nil
    }

    func testExerciseNetworking() {
        //XCTestExpectation makes your test wait for Asynchronous operation to complete.
        let promise = XCTestExpectation(description: "Fetch Data Completed")
        var responseError : Error?
        var responseResult : ExerciseResponse?
        
        guard let bundle =  Bundle.unitTest.path(forResource: "ExerciseAPIMock", ofType: "json") else {
            XCTFail("Error : Content not found")
            return
        }
        
        let url = URL(fileURLWithPath: bundle)
        var exercisesNetworking = ExercisesNetworking.getExercisesData
        exercisesNetworking.baseURL = url.absoluteString
        
        
        exerciseNetworking.fetchData(target: exercisesNetworking, responseClass: ExerciseResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                responseResult = response
            case .failure(let error):
                responseError = error
            }
            // mark expectation as having been meet
            promise.fulfill()
            self?.wait(for: [promise], timeout: 1)
            XCTAssertNil(responseError)
            XCTAssertNotNil(responseResult)
            
            let firstExercise = responseResult?.results.first
            XCTAssertEqual("2 Handed Kettlebell Swing", firstExercise?.name)
            XCTAssertEqual("Two Handed Russian Style Kettlebell swing", firstExercise?.exerciseDescription)
            
            let lastExercise = responseResult?.results.last
            XCTAssertEqual("Biceps Curls With Barbell", lastExercise?.name)
            XCTAssertEqual(74, lastExercise?.id)
            
        }
        
    }
}
