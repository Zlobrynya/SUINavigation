//
//  PopToUITests.swift
//  NavigationExampleUITests
//
//  Created by Sergey Balalaev on 13.10.2023.
//

import XCTest

final class PopToUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testJustBack() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .tapSecond()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("Second")
            .tapPopTo()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapBack()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
    }

    func testTwoBack() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("First")
            .tapPopTo()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapBack()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
    }

    func testBackToSecondChanged() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .tapSecond()
        SecondView(app: app)
            .checkThis(number: 11)
            .checkChanging(false)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapChange()
            .enterPopToTextField("Second")
            .tapPopTo()
        SecondView(app: app)
            .checkThis(number: 11)
            .checkChanging(true)
            .tapBack()
        MainView(app: app)
            .checkThis()
    }

    func testBackToFirstChanged() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .checkChanging(false)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapChange()
            .enterPopToTextField("First")
            .tapPopTo()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .checkChanging(true)
            .tapBack()
        MainView(app: app)
            .checkThis()
    }

    func testDoublePopTo() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("First")
            .tapPopTo()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("First")
            .dissmissKeyboard()
            .tapChange()
            .tapPopTo()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapBack()
        MainView(app: app)
            .checkThis()
    }

    func testManyScreensPopTo() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Bool")
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapChange()
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Bool")
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapChange()
            .enterPopToTextField("Second")
            .tapPopTo()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBack()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapBack()
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .checkRootMessage(tapOK: true)
    }

    func testPopToRoot() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapChange()
            .enterPopToTextField("")
            .tapPopTo()
        MainView(app: app)
            .checkThis()
            .checkChanging(true)
    }

    func testNotFound() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapSecond()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("First")
            .tapPopTo()
            .checkThis()
            .tapBack()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapBack()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
    }

    func testPopToTheSame() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapSecond()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("Bool")
            .tapPopTo()
            .checkThis()
            .tapBack()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapBack()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
    }

    // It's not bug, a feature. When stack has the same id, we can not pop to it.
    func testPopToTheSameWithDouble() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Bool")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("Bool")
            .tapPopTo()
        BoolView(app: app)
            .checkThis()
            .tapBack()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBack()
        FirstView(app: app)
            .checkThis(string: "Bool")
            .tapBack()
        BoolView(app: app)
            .checkThis()
            .tapBack()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
    }

    func testPopToManyClones() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Bool")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapBool()
        BoolView(app: app)
            .checkThis()
            .tapChange()
            .enterPopToTextField("First")
            .tapPopTo()
        FirstView(app: app)
            .checkThis(string: "Bool")
            .tapBack()
        BoolView(app: app)
            .checkThis()
            .enterPopToTextField("First")
            .tapPopTo()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapBack()
        MainView(app: app)
            .checkThis()
    }

    func testPop() throws {
        let app = XCUIApplication.launchEn
        MainView(app: app)
            .checkThis()
            .checkChanging(false)
            .tapSecond()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapPop()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
            .tapFirst()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapSecond22()
        SecondView(app: app)
            .checkThis(number: 22)
            .tapPop()
        FirstView(app: app)
            .checkThis(string: "Hi")
            .tapBack()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
            .tapSecond()
        SecondView(app: app)
            .checkThis(number: 11)
            .tapPop()
        MainView(app: app)
            .checkThis()
            .checkRootMessage(tapOK: true)
    }
}
