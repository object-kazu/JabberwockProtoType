//
//  css_JW_TEST.swift
//  JabberWock
//
//  Created by kazuyuki shimizu on 2017/01/05.
//  Copyright © 2017年 momiji-mac. All rights reserved.
//

import XCTest

class css_JW_TEST: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_JW_css() {
        
        // style
        var s = CSS.property()
        s.Color = "red"
        
        
        let jw = JWObject()
        jw.style = CSS(name: "jw", property: s)

        XCTAssertEqual(jw.styleStr(), "jw {" + RET + "color: red;" + RET + "}")
        
    }

    func test_property_case1 () {
        var style = CSS.property()
        style.Color = "red"
        style.Font.size = "12"
        
        let t = CSS(name: "test", property: style)
        
        XCTAssertEqual(t.Str(), "test {" + RET + "color: red;" + RET + "font-size: 12;" + RET + "}")
    }


    func test_JW_css2() {
        let jw = JWObject()
        let css = CSS(name: "jw")
        css.property.Color = "red"
        css.property.Opacity = "0.5"
        jw.style = css
        
        XCTAssertEqual(jw.styleStr(), "jw {" + RET +
            "color: red;" + RET +
            "opacity: 0.5;" + RET +
            "}")
    }
    
//    func test_JW_css_addMember() {
//        let jw = JWObject()
//        let css = CSS(name: "jw")
//        css.color.value = "red"
//        css.opacity.value = "0.5"
//        jw.style = css
//        
//        let jw2 = JWObject()
//        let css2 = CSS(name: "jw2")
//        css2.color.value = "blue"
//        css2.opacity.value = "0.1"
//        jw2.style = css2
//        
//        jw.addMember(member: jw2)
//        
//        XCTAssertEqual(jw.styleStr(), "jw {" + RET +
//            "color: red;" + RET +
//            "opacity: 0.5;" + RET +
//            "}" + RET +
//            "jw2 {" + RET +
//            "color: blue;" + RET +
//            "opacity: 0.1;" + RET +
//            "}"
//        )
//    }

//    func test_JW_css_addChild() {
//        let jw = JWMulti()
//        let css = CSS(name: "jw")
//        css.color.value = "red"
//        css.opacity.value = "0.5"
//        jw.style = css
//        
//        let jw2 = JWObject()
//        let css2 = CSS(name: "jw2")
//        css2.color.value = "blue"
//        css2.opacity.value = "0.1"
//        jw2.style = css2
//    
//        jw.addChild(child: jw2)
//        
//        XCTAssertEqual(jw.styleStr(), "jw {" + RET +
//            "color: red;" + RET +
//            "opacity: 0.5;" + RET +
//            "}" + RET +
//            "jw2 {" + RET +
//            "color: blue;" + RET +
//            "opacity: 0.1;" + RET +
//            "}"
//        )
//    }

//    func test_JW_css_repeat() {
//        let jw = JWObject()
//        let css = CSS(name: "jw")
//        css.color.value = "red"
//        jw.style = css
//        
//
//        let jw2 = JWObject()
//        jw2.style = css
//        
//        jw.addMember(member: jw2)
//        
//        XCTAssertEqual(jw.styleStr(), "jw {" + RET + "color: red;" + RET + "}")
//        
//    }

//    func test_myCSS (){
//        let t = P(content: "test")
//        let css = CSS(tag: t)
//        css.color.value = "red"
//        t.style = css
//        XCTAssertEqual(t.styleStr(), "p {" + RET + "color: red;" + RET + "}")
//
//    }

//    func test_css_no_id () {
//        let t = P(content: "test")
//        t.prepStyleByID()
//        t.style.color.value = "red"
//        
//        // no id
//        XCTAssertEqual(t.styleStr(), "")
//
//    }
//    
//    func test_css_id () {
//        let t = P(content: "test")
//        t.setID(id: "popo")
//        t.prepStyleByID()
//        t.style.color.value = "red"
//        
//        // no id
//        XCTAssertEqual(t.styleStr(), "#popo {" + RET + "color: red;" + RET + "}")
//        
//    }

    
}
