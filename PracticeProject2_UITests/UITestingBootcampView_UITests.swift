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
        app.launchArguments = ["-UITest_startSignedIn"]
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_UITestingBootcampView_signUpButton_shouldNotSignIn() {
        //Given
        signUpAndSignIn(shouldTypeOnTheKeyboard: false)
        
        //When
        let navBar = app.navigationBars["Welcome"]
        
        //Then
        XCTAssertFalse(navBar.exists)
        
    }
    
    func test_UITestingBootcampView_signUpButton_shouldSignIn() {
        //Given
        signUpAndSignIn(shouldTypeOnTheKeyboard: true)
        
        //When
        
        let navBar = app.navigationBars["Welcome"]
        
        //Then
        XCTAssertTrue(navBar.exists)
    }
    
    
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
        //Given
        signUpAndSignIn(shouldTypeOnTheKeyboard: true)
        
        //when
        tapAlertButton(shouldDismissAlert: false)
        
        //then
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    
    
    func test_SignedInHomeView_showAlertButton_shouldNotDisplayAlert() {
        
        //Given
        signUpAndSignIn(shouldTypeOnTheKeyboard: true)
        
        //When
        tapAlertButton(shouldDismissAlert: true)
        
        //then
        let alertExists = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssertFalse(alertExists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestination() {
        //Given
        signUpAndSignIn(shouldTypeOnTheKeyboard: true)
        
        //When
        
        let navLinkButton = app.buttons["NavigationLinkToDestination"]
        navLinkButton.tap()
        
        tapNavigationLink(shouldDismissDestination: false)
        let destinationText = app.staticTexts["destination"]
        //then
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        //Given
        signUpAndSignIn(shouldTypeOnTheKeyboard: true)
        
        //When        
        tapNavigationLink(shouldDismissDestination: true)

        //then
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)                    
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack2() {
        //Given
        //When        
        tapNavigationLink(shouldDismissDestination: true)

        //then
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
    }
}

//MARK: dodatne funkcije

extension UITestingBootcampView_UITests {
    func signUpAndSignIn(shouldTypeOnTheKeyboard: Bool) {
        let textField = app.textFields["SignUpTextField"]
        textField.tap()
        
        if shouldTypeOnTheKeyboard {
            let keyA = app.keys["A"]
            keyA.tap()
             
            let keya = app.keys["a"]
            keya.tap()
            keya.tap() 
        }
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }
    
    func tapAlertButton(shouldDismissAlert: Bool) {
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        if shouldDismissAlert {
            let alert = app.alerts.firstMatch
            let alertOkButton = alert.buttons["OK"]
            
            let alertOkButtonExists = alertOkButton.waitForExistence(timeout: 5)
            XCTAssertTrue(alertOkButtonExists)
            
            alertOkButton.tap()
        }
    }
    
    func tapNavigationLink(shouldDismissDestination: Bool) {
        let navLinkButton = app.buttons["NavigationLinkToDestination"]
        navLinkButton.tap()
        
        if shouldDismissDestination {
            let backButton = app.navigationBars.buttons["Welcome"]
            backButton.tap()
        }
    }
}
