//
//  ClipboardModel.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa



class ClipboardModel: Model {
    
    struct Instances {
        static var instances: [ClipboardModel] = []
    }

    var text: String?


    /// 初期化
    //-------------------------------------------------------------------------------
    required init() {
        

        
        /// インスタンス生成
        //-------------------------------------------------------------------------------
        super.init()
        
    }
    
    /// 全てのインスタンスを取得
    //-------------------------------------------------------------------------------
    class func all () -> NSArray {
        return Instances.instances
        
    }
    
    //// インスタンスの追加 TODO: 将来的にこのクラスを 基底クラスに移動させる
    //-------------------------------------------------------------------------------
    class func create (text: String) -> ClipboardModel? {
        
        /// 重複したテキストを除外する
        //-------------------------------------------------------------------------------
        for i in Instances.instances {
            if i.text == text {
                return nil
            }
        }
        
        var newInstance = self()
        newInstance.text = text
        Instances.instances.append( newInstance )
        return newInstance
    }



}
