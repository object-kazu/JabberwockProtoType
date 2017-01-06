//
//  JW.swift
//  JabberWock
//
//  Created by 清水 一征 on 2016/12/03.
//  Copyright © 2016年 momiji-mac. All rights reserved.
//

import Foundation

let EXPORT_TEST_Dir = "/Users/shimizukazuyuki/Desktop/index/"
let EXPORT_TEST_File = "result.txt"


/*
 
 <tag> content </tag>

 <member> xxxx </member>
 <member> xxxx </member>
 <member> xxxx </member>
 
 
 */

class JWSingle: JW {
    
    var content :  String  = ""

    override init() {
        super.init()
        initilizer()

    }

    init(content: String) {
        super.init()
        self.initilizer()
        self.content = content
    }

    
    func initilizer () {
        self.openString = ""
        self.closeString = ""
    }

    override func assemble(){
        makeTag()
        makeResult()
    }
    
    override func makeResult() {
        
        resultString = openString + content
        
        if !closeString.isEmpty {
            resultString += closeString
        }
        
    }
    
}

/*
 
 <tag>
    child
    child
    child
    child
 </tag>

 <member> xxxx </member>
 <member> xxxx </member>
 <member> xxxx </member>

 
 */

class JWMulti: JW {
    
    var childString: [String] = []
    
    // add child
    func addChild (child : JW){
       
        // html
        child.assemble()
        self.addCihld(child: child.resultString)
        
        // css
        if child.styleArray.count > 0{
            styleArray.append(contentsOf: child.styleArray)
        }
        styleArray.append(child.style)
        
    }
    
    func addChildren (children : [JW]){
        for c: JW in children {
            addChild(child: c)
        }
    }
    
    
    func addCihld (child: String) {
        let t = child.replacingOccurrences(of: RET, with: RET + TAB)
        childString.append(t)
    }

    
    override func assemble() {
        makeTag()
        makeResult()
    }
    
    override func makeResult() {
        
        resultString += openString + RET
        
        childAssemble()
        
        if !closeString.isEmpty {
            resultString += closeString
        }
        
        // 最後のRETを取り除く
        resultString = removeLastRET(str: resultString)
        
        
    }
    
    func childAssemble () {
        for str in childString {
            resultString += TAB + str
            resultString += TAB + RET
           }
    }

    
    
}



class JW {
    
    
    private var tagManager      : TagString = TagString()
    var openString              : String!
    var closeString             : String!
    
    var resultString    : String    = ""
    var memberString: [String]      = []

    /// css
    var style :CSS          = CSS(name: "")
    var styleArray : [CSS]  = []
    var styleString: String = ""
    //var styleStrings: [String] = []
    
    func styleStringInit () {
        styleString = "" // initilize
    }
    
    private func styleAssemble () {
        
        var tempStyle : [CSS] = []
        tempStyle.append( style )
        tempStyle.append(contentsOf: styleArray)
        
        for sty in tempStyle {
            /// スタイルがない（｛｝のみ）なら標示しない
            /// 同じ名前のスタイルは書き込まない（重複書き込み禁止）
            if sty.Str().isEmpty {
                continue
            }
            
            if isSameCSSName(name: sty.cssName) {
                continue
            }
            styleString += sty.Str()
            styleString += RET
            
            
        }
        
        styleString = removeLastRET(str: styleString)
        
    }
    
    
    private func isSameCSSName (name: String) -> Bool {
        return styleString.contains(name) ? true : false
    }
    
    func applyStyle() {
        styleAssemble()

        
        
        ///検索のためにStyle tag生成
        let s = STYLE()
        s.makeTag()
        if resultString.contains(s.openString) && resultString.contains(s.closeString) {
            // insert tab
            let tn = getTabNumber(testStr: resultString, targetStr: STYLE_CONTENT)
            let tabedString = addTab(str: styleString, tabMax: tn)

            // replace text
            // 余分なTabを削除しておく
            var target = ""
            for _ in 0..<tn {
                target += TAB
            }
            target += STYLE_CONTENT
            resultString = resultString.replacingOccurrences(of: target, with: STYLE_CONTENT) // TAB + TAB + STYLE_CONTENT -> STYLE_CONTENT
            resultString = resultString.replacingOccurrences(of: STYLE_CONTENT, with: tabedString)
        }
    }
    
    // tab揃え
    private func tabNumber (str: String) -> Int {
        let last = removeLastTAB(str: str) //余分なTabを除く
        let a = last.components(separatedBy: "\t")
        return a.count - 1
    }
   
    
    
    private func addTab (str: String, tabMax : Int) -> String {
        var ans = ""
        let l = str.lines
        for e:String in l {
            let tn = tabNumber(str: e)
            let a = tabMax - tn
            let s = addheadTab(str: e, num: a)
            ans += s
            ans += "\n"
        }
        
        return ans
    }
    
    private func addheadTab (str: String, num:Int) -> String {
        var t = ""
        for _ in 0..<num {
            t += "\t"
        }
        t += str
        return t
    }
    
    private func getTabNumber (testStr:String, targetStr: String ) -> Int {
        let lin = testStr.lines
        for l in lin {
            if l.contains(targetStr) {
                return tabNumber(str: l)
            }
        }
        return 0
    }
    
    private func getTabMax (testStr:String) -> Int {
        var max = 0
        let lin = testStr.lines
        for l in lin {
            let n = tabNumber(str: l)
            if n > max {
                max = n
            }
        }
        return max
        
    }
    
    // remove last \n
    func removeLastRET (str: String) -> String {
        if str.hasSuffix("\n") {
            return str.substring(to: str.index(before: str.endIndex))
        }
        return str
    }
    func removeLastTAB (str: String) -> String {
        if str.hasSuffix("\t") {
            return str.substring(to: str.index(before: str.endIndex))
        }
        return str
    }
    
    //export string
    func tgStr () -> String {
        assemble()
        return resultString
    }
    
    func styleStr () -> String {
        styleStringInit()
        styleAssemble()
        return styleString
    }
    
    // tag
    func isBRTag (single: Bool) {
        tagManager.isBRTag = single
    }
    func isSingleTag (single: Bool) {
        tagManager.isSingleTag = single
    }
    
    func setID(id:String) {
        tagManager.id = id
    }
    
    func setCls(cls:String) {
        tagManager.cls = cls
    }
    func setName(name:String) {
        tagManager.name = name
    }
    func setLang(lang:LANG) {
        tagManager.lang = lang
    }
    
    
    // tagの変更時には必ず呼び出しアップデート
    func makeTag() {
        openString = tagManager.openString()
        closeString = tagManager.closeString()
    }
    
    // add member
    func addMember(member:String)  {
        memberString.append(member)
    }
    
    func addMember (member: JW){
        // html
        member.assemble()
        addMember(member: member.resultString)
        
        // css
        if member.styleArray.count > 0{
            styleArray.append(contentsOf: member.styleArray)
        }

        styleArray.append(member.style)
        
    }
    func addMembers (members: [JW]) {
        for m: JW in members {
            m.addMember(member: m)
        }
    }
    
    
    func assemble(){}
    func makeResult(){}
    
    func memberAssemble () {
        
        if memberString.count > 0 {
            resultString += RET
            
            var m: String = ""
            for t: String in memberString {
                m += t
                m += RET
            }
            
            resultString += m
        }
    }
    
    // ファイルに書き出す
    func press(name: String, dist : String){
        
        assemble()
        memberAssemble()
        applyStyle()
        
        
        // ドキュメントパス
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        // 保存するもの
        let fileObject = resultString
        // ファイル名
        let fileName = name
        // 保存する場所
        let filePath = documentsPath + fileName
        
        // 保存処理
        do {
            try fileObject.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Fail to write result at text file")
            
        }
        
       
        
        //file exist
        let fileManager = FileManager.default
        let path = dist + name
        
        if fileManager.fileExists(atPath: path){
            // remove file
            print("file remove!")
            removeFile(path: path)
        }
        
        // file move
        do{
            try fileManager.moveItem(atPath: filePath, toPath:path)
        } catch {
            assertionFailure("move error")
        }

        
    }
    
    
    
    func press ()  {
        self.press(name: EXPORT_TEST_File, dist: EXPORT_TEST_Dir)
    }
    
    
    func removeFile(path:String){
        let fileManager = FileManager.default

        do {
            try fileManager.removeItem(atPath: path)
            print("Removal successful")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
 }
