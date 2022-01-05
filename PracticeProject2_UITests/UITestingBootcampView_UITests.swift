 //
//  UITestingBootcampView_UITests.swift
//  PracticeProject2_UITests
//
//  Created by Luka Vujnovac on 05.01.2022..
//

import XCTest

//Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
//Naming Structure: test_[struct]_[ui component]_[expected result]
//Testing Structure: Given, When, Then

class UITestingBootcampView_UITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_UITestingBootcampView_signUpButton_shouldNotSignIn() {
        //Given
        let textField = app.textFields["SignUpTextField"]
        
        //When
        textField.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        //Then
        XCTAssertFalse(navBar.exists)
        
    }
    
    func test_UITestingBootcampView_signUpButton_shouldSignIn() {
        //Given
        let textField = app.textFields["SignUpTextField"]
        
        //When
        textField.tap()
        let keyA = app.keys["A"]
        keyA.tap()
         
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        //Then
        XCTAssertTrue(navBar.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
                
    }
    
    func test_SignedInHomeView_showAlertButton_shouldNotDisplayAlert() {
        
        //Given
        let textField = app.textFields["SignUpTextField"]
        
        //When
        textField.tap()
        let keyA = app.keys["A"]
        keyA.tap()
         
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        
        let alertOkButton = alert.buttons["OK"]
//        XCTAssertTrue(alertOkButton.exists)
        
        let alertOkButtonExists = alertOkButton.waitForExistence(timeout: 5)
        XCTAssertTrue(alertOkButtonExists)
        
        alertOkButton.tap()
        
        //sleep(1)
        let alertExists = alert.waitForExistence(timeout: 5)
        
        //then
        XCTAssertFalse(alertExists)
    }

}
