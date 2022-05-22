//
//  RegisterUnitTest.swift
//  OSBC TestTests
//
//  Created by frizar fadilah on 20/05/22.
//

import XCTest
import RxSwift
@testable import OSBC_Test

class RegisterUnitTest: XCTestCase {

    var sut: RegisterService!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        sut = RegisterService()
    }
    
    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func registerTests() {
        let statusJson = "{\"status\":\"success\"}"//
        MockURLProtocol.stubResponseData = statusJson.data(using: .utf8)
        
        let expectation = self.expectation (description: "Register Response Expectation")
        
        sut.register(username: "test", password: "asdasd")
            .subscribe(onNext: { items in
                //if success then token not null
                XCTAssert(items.token != nil, "if token data get then success, else failed")
                expectation.fulfill()
                
            }, onError: { error in
                XCTAssertNil(error.localizedDescription, "The response model for a request containing unknown JSON response, should have been nil")
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func errorRegisterTests() {
        // Arrange
        let status = "{\"message\":\"failed\"}"
        
        MockURLProtocol.stubResponseData =  status.data(using: .utf8)
        
        let expectationError = expectation(description: "Error Register Expectation")
        
        //Act
        sut.register(username: "test", password: "asdasds")
            .subscribe(onNext: { items in
                print("Response = \(items.status ?? "")")
                
            }, onError: { error in
                XCTAssertNil(error.localizedDescription, "The response model for a request containing unknown JSON response, should have been nil")
                XCTAssertEqual(error.localizedDescription, "Success")
                expectationError.fulfill()
            }).disposed(by: disposeBag)
        
        //waitForExpectations(timeout: 5.0, handler: nil)
        self.wait(for: [expectationError], timeout: 5)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
