//
//  CatsAndModulesUITests.swift
//  CatsAndModulesUITests
//
//  Created by Kyrylo Derkach on 26.05.2023.
//

import XCTest

final class CatsAndModulesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        setupSnapshot(app)
    }

    func testSnapshots() throws {
        app.alerts.element.buttons["Accept"].tap()
        sleep(5)
        snapshot("KyryloDerkach_MainScreen")
        
        app.otherElements.element(boundBy: 0).tap()
        sleep(5)
        snapshot("KyryloDerkach_DetailsScreen")
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
