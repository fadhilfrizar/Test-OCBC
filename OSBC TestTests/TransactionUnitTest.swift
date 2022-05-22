//
//  TransactionUnitTest.swift
//  OSBC TestTests
//
//  Created by frizar fadilah on 23/05/22.
//

import XCTest
import RxSwift
@testable import OSBC_Test

class TransactionUnitTest: XCTestCase {
    
    var sut: TransactionService!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        sut = TransactionService()
    }
    
    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func getTransactionTests(){

        let status = "{\"status\":\"success\"}"

        MockURLProtocol.stubResponseData = status.data(using: .utf8)
        
        let expectation = self.expectation (description: "Present Get Transaction Data Expectation")
        
        sut.transaction()
            .subscribe(onNext: { items in
                XCTAssertEqual(items.status, "success")
                expectation.fulfill()

            }, onError: { error in
                XCTAssertNil(error.localizedDescription, "The response model for a request containing unknown JSON response, should have been nil")
                expectation.fulfill()
            }).disposed(by: disposeBag)

        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func errorTransactionTests() {
        // Arrange
        let status = "{\"message\":\"failed\"}"
        
        MockURLProtocol.stubResponseData =  status.data(using: .utf8)
        
        let expectationError = expectation(description: "Error Transaction Expectation")
        
        //Act
        sut.transaction()
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
