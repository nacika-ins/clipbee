//
//  Model.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa

class Model: NSObject {
    
    /// <##>
    //-------------------------------------------------------------------------------
    init() {
        super.init()
    }
    
    /// 作成されたインスタンスを保持する
    //-------------------------------------------------------------------------------
    class var instances: NSMutableArray {
        struct Instances {
            static let instances: NSMutableArray = []
        }
        return Instances.instances
    }
    
    /// 全てのインスタンスを取得
    //-------------------------------------------------------------------------------
    class func all () -> NSArray {
    
        var array = self.instances
        
        return array
        
    }
    
    //// インスタンスの追加
    //-------------------------------------------------------------------------------
    class func create () {
    
        println(self.instances)
        
    }

}
