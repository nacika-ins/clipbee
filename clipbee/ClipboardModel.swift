//
//  ClipboardModel.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa



class ClipboardModel: Model {
    
    
    /// シングルトン
    //-------------------------------------------------------------------------------
    class var sharedInstance : ClipboardModel
        {
    struct Singleton {
        static let instance = ClipboardModel()
        }
        return Singleton.instance
    }
    
    /// クリップボードコントローラインスタンスの取得
    //-------------------------------------------------------------------------------
    // var clipCon = ClipboardController.sharedInstance
    
    /// 初期化
    //-------------------------------------------------------------------------------
    init() {
        
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        // println("ClipboardModelが初期化されました")
        
        /// インスタンス生成
        //-------------------------------------------------------------------------------
        super.init()
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        // println(clipboardModelSharedInstanceVariable)
    }
    



}
