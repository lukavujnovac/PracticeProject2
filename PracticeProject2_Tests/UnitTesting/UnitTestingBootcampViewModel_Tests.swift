//
//  UnitTestingBootcampViewModel_Tests.swift
//  PracticeProject2_Tests
//
//  Created by Luka Vujnovac on 29.12.2021..
//

import XCTest
import Combine
@testable import PracticeProject2

//Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
//Naming Structure: test_[struct or class]_[variable or function]_[expected result]

//Testing Structure: Given, When, Then

class UnitTestingBootcampViewModel_Tests: XCTestCase {    
    
    var viewModel: UnitTestingBootcampViewModel?
    var cancellabels = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
    }  
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        //Given
        let userIsPremium: Bool = true
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse() {
        //Given
        let userIsPremium: Bool = false
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue() {
        //Given
        let userIsPremium: Bool = Bool.random()
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            //Given
            let userIsPremium: Bool = Bool.random()
            
            //When
            let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
            
            //Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        //Given
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    } 
    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItems() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
            
        }
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString2() {
        //Given
        
        guard let vm = viewModel else {
            XCTFail()
            return
            
        }
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldStartAsNil() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        //select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        //select invalid item
        vm.selectItem(item: UUID().uuidString)
        
        //Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        vm.selectItem(item: UUID().uuidString)
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected_stress() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
        XCTAssertFalse(randomItem.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_itemNotFound () {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "should throw item not found error") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_noData () {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        do {
            try vm.saveItem(item: "")
        }catch let error{
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldSaveItem() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        
        //Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        XCTAssertFalse(randomItem.isEmpty)
        
        do {
            try vm.saveItem(item: randomItem)
        }catch {
            XCTFail()
        }
    }
    
    func test_UnitTestingBootcampViewModel_downloadWithEscaping_shouldReturnItems() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let expectation = XCTestExpectation(description: "should return items after 3 seconds")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellabels)
        
        vm.downloadWithEscaping()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_downloadWithCombine_shouldReturnItems() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let expectation = XCTestExpectation(description: "should return items after 1 second")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellabels)
        
        vm.downloadWithCombine()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
}
