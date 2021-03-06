//
//  headingTest.swift
//  JabberWock
//
//  Created by 清水 一征 on 2016/12/16.
//  Copyright © 2016年 momiji-mac. All rights reserved.
//

import XCTest

class headingTest: XCTestCase {
    
    var dctype = DOCTYPE()
  
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func test_headings_h1 (){
        let h1 = HEADING()
        h1.level = 0 // h1 tag
        let ans = h1.press()
        XCTAssertEqual(ans, "<h1></h1>")
        /* answer
         <h1></h1>
         
         */
        
    }
    func test_headings_h6 (){
        let h1 = HEADING()
        h1.level = 10 // h6 tag
        let ans = h1.press()
        XCTAssertEqual(ans, "<h6></h6>")
        
        /* answer
         <h6></h6>
         */
    }
    
    func test_heading_contents () {
        let h1 = HEADING()
        h1.level = 1
        h1.content = "test"
        let ans = h1.press()
        XCTAssertEqual(ans, "<h1>test</h1>")
        
        /* answer
         <h1>test</h1>
         
         */
    }
    
    func test_heading_init(){
        let h2 = HEADING(level: 2, content: "init test")
        let ans = h2.press()
        XCTAssertEqual(ans, "<h2>init test</h2>")
        
        /* answer
         <h2>init test</h2>
         */
        
    }
    
    func test_heading_id(){
        let h2 = HEADING(level: 2, content: "init test")
        h2.setID(id: "header2")
        let ans = h2.press()
        XCTAssertEqual(ans, "<h2 id=\"header2\">init test</h2>")
        
        /* answer
         <h2 id="header2">init test</h2>
         */
        
    }
    func test_heading_h1_h2 () {
        let h1 = HEADING()
        h1.level = 1
        h1.content = "test h1"
        
        let h2 = HEADING()
        h2.level = 2
        h2.content = "test h2"
        
        dctype.addMember(member: h1)
        dctype.addMember(member: h2)
        dctype.press()
        /* answer
         <!DOCTYPE html>
         <h1>test h1</h1>
         <h2>test h2</h2>

         
         */
    }

}
