//
//  globaDef.swift
//  JabberWock
//
//  Created by 清水 一征 on 2016/12/15.
//  Copyright © 2016年 momiji-mac. All rights reserved.
//

import Foundation

let RET         : String    = "\n"
let TAB         : String    = "\t"
let SPC         : String    = " "
let COMMA       : String    = ","
let COLON       : String    = ":"
let SEMI_COLON  : String    = ";"


let INSERTSTRING: String    = "%%"
let STYLE_CONTENT: String   = "##STYLE##"

// Table
let BLA: String = "<br>"
let ROW_SPAN = "%rowSpan="
let COL_SPAN = "%colSpan="


// - extention
extension String {
    
    var lines: [String] {
        var lines = [String]()
        self.enumerateLines { (line, stop) -> () in
            lines.append(line)
        }
        return lines
    }
    
}
