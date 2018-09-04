//
//  Networking_LayerTests.swift
//  Networking LayerTests
//
//  Created by Vitor Ferraz Varela on 03/09/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import XCTest
@testable import Networking_Layer

extension XCTestCase{
    func loadStubFromBundle(withName name:String , extension:String)->Data{

        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
}


class Networking_LayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let dataJSON = loadStubFromBundle(withName: "mock", extension: "json")
        ResultHelper.map(dataJSON)


    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


    
}
