//
//  ClipboardModel.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa



class ClipboardModel: Model {
    
    /// initで呼ばれたタイミングではまだnilになっているため、nilを許容します。
    //-------------------------------------------------------------------------------
    var text: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var title: String?
    var isProtect: Bool?
    
    /// super.initで呼ばれる初期化。この初期化は super.init()で呼ばれます。
    //-------------------------------------------------------------------------------
    init(_ dict: Dictionary<String, String>) {
        
        /// ディクショナリからデータを取得しインスタンスを初期化します。
        //-------------------------------------------------------------------------------
        println("3. ディクショナリからデータを取得しインスタンスを初期化します。")
        
        /// 親クラスのイニシャライザ呼び出し
        //-------------------------------------------------------------------------------
        super.init(dict)
        
        /// 現在時刻の取得
        //-------------------------------------------------------------------------------
        var nowTime: NSDate = NSDate()
        var updateTime: NSDate = NSDate( timeInterval:0, sinceDate:nowTime )
        self.text = NSString(string: dict["text"])
        
        self.createdAt = nowTime
        self.updatedAt = updateTime
        self.isProtect = false
        
        
    }
    

}
