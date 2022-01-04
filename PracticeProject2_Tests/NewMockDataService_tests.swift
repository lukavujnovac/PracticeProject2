//
//  NewMockDataService_tests.swift
//  PracticeProject2_Tests
//
//  Created by Luka Vujnovac on 04.01.2022..
//

import XCTest
import Combine
@testable import PracticeProject2


class NewMockDataService_tests: XCTestCase {
    
    var cancellabels = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellabels.removeAll()
    }

    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        //Given
        let items1: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString ]
        
        //When
        let dataService1 = NewMockDataService(items: items1)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        //Then
        XCTAssertFalse(dataService1.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        //Given
        
        let dataService = NewMockDataService(items: nil)
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)

    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        //Given
        
        let dataService = NewMockDataService(items: nil)
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure:
                        XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellabels)

        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        //Given
        
        let dataService = NewMockDataService(items: [])
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw an URlError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTFail()
                    case .failure(let error):
                        expectation.fulfill()
                        
//                        let urlError = error as? URLError
//                        XCTAssertEqual(urlError, URLError(.badServerResponse))
                        
                        if error as? URLError == URLError(.badServerResponse) {
                            expectation2.fulfill()
                        }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellabels)

        //Then
        wait(for: [expectation, expectation2 ], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }

}
