//
//  Model.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa

class Model: NSObject {
    

    /// サブクラスの init の super.init() から呼ばれます。
    /// @note クラスメソッドでサブクラスのインスタンスを生成する場合は、その初期化を行うための親クラスのイニシャライザに@required を指定する必要があります。
    //-------------------------------------------------------------------------------
    @required init(_ dict: Dictionary<String, String>) {
        println("4. サブクラスの @required init の super.init() から呼ばれます。")
    }

    /// 作成されたインスタンスを保持する
    //-------------------------------------------------------------------------------
    class var instances: Array<Model> {
        struct Instances {
            static var instances: Array<Model> = []
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
    class func create (dict: Dictionary<String, String>) {
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("2. インスタンスの追加を行います")
    
        /// インスタンスの生成 （）
        //-------------------------------------------------------------------------------
        var i = self(dict)
        
        /// 配列に追加する
        //-------------------------------------------------------------------------------
        var a = self.instances
        
        /// 追加
        //-------------------------------------------------------------------------------
        a.append(i)
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println(a)

    }

}
