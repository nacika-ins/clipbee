//
//  ClipboardModel.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa

var clipboardModelSharedInstanceVariable: ClipboardModel! = nil

class ClipboardModel: Model {
    
    /// クラスメソッド
    //-------------------------------------------------------------------------------
    class func sharedInstance() -> ClipboardModel {
        if (clipboardModelSharedInstanceVariable == nil) {
            return ClipboardModel()
        }
        else {
            return clipboardModelSharedInstanceVariable
        }
        
    }
    
    /// 初期化
    //-------------------------------------------------------------------------------
    init() {
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        // println("ClipboardModelが初期化されました")
        
        /// インスタンス生成
        //-------------------------------------------------------------------------------
        super.init()
        if (clipboardModelSharedInstanceVariable == nil) {
            clipboardModelSharedInstanceVariable = self
        }
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        // println(clipboardModelSharedInstanceVariable)
    }
    
    /// クリップボードの監視を行う
    //-------------------------------------------------------------------------------
    func clipboardCaptureStart() -> Bool {
    
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("クリップボードの監視を開始しました")
        
        /// スレッド作成
        //-------------------------------------------------------------------------------
        // NSThread.detachNewThreadSelector("clipboardWatcher:", toTarget:self, withObject:nil)
        
        /// スレッド作成
        //-------------------------------------------------------------------------------
        var nst = NSThread(target:self, selector:"clipboardWatcher", object:nil)
        nst.start()
        
        return true
    
    }
    
    /// クリップボード監視処理
    //-------------------------------------------------------------------------------
    func clipboardWatcher() {
        
        
        println("スレッドが起動しました")
        
        /// スレッド監視処理ルーティン
        //-------------------------------------------------------------------------------
        var cc = ClipboardController()
        
        
    }
    
    


}