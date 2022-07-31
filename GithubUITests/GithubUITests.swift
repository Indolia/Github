//
//  GithubUITests.swift
//  GithubUITests
//
//  Created by Rishi Indolia on 30/07/22.
//

import XCTest
@testable import Github

class GithubUITests: XCTestCase {

    override func setUpWithError() throws {
        IKeyChain.shared.delete(key: AppConstants.UserInfo.key)
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginAsMemberShoudNotHaveBackButton() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Member"].tap()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let ownerNameField = elementsQuery.textFields["Repo Owner Name"]
        ownerNameField.tap()
        ownerNameField.typeText("Indolia")
        ownerNameField.typeText("\n")
        
        let repoNameField = elementsQuery.textFields["Repo Name"]
        repoNameField.tap()
        repoNameField.typeText("Github")
        repoNameField.typeText("\n")
        
        let authField = elementsQuery.secureTextFields["Auth Token"]
        authField.tap()
        authField.typeText("demmuy auth")
        authField.typeText("\n")
        
        XCTAssertEqual(ownerNameField.value as! String, "Indolia")
        XCTAssertEqual(repoNameField.value as! String, "Github")
        XCTAssertNotNil(authField.value)
        
        elementsQuery.buttons["Submit"].tap()
        
        let backButton = app.navigationBars["Login"]
        let logoutButton = app.buttons["logoutButton"]
        XCTAssertFalse(backButton.isHittable)
        XCTAssertTrue(logoutButton.isHittable)
        logoutButton.tap()
        sleep(5)
    }

    func testLoginAsGuestHaveBackButtonAndNotHaveLogoutButton() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Guest"].tap()
        let backButton = app.navigationBars.element(boundBy: 0)
        let logoutButton = app.buttons["logoutButton"]
        XCTAssertTrue(backButton.isHittable)
        XCTAssertFalse(logoutButton.isHittable)
    }
}
