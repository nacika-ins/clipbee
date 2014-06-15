//
//  AppDelegate.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    /// ウィンドウ
    //-------------------------------------------------------------------------------
    @IBOutlet var window: NSWindow
    
    /// リストテーブル
    //-------------------------------------------------------------------------------
    @IBOutlet var clipHistoryTable : NSTableView


    /// 起動が完了した
    //-------------------------------------------------------------------------------
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        
        /// クリップボードモデルインスタンスの生成
        //-------------------------------------------------------------------------------
        var cm = ClipboardModel.sharedInstance()
        
        /// クリップボードの監視を行う
        //-------------------------------------------------------------------------------
        cm.clipboardCaptureStart()



        
        /// クリップボードの監視を開始する
        //-------------------------------------------------------------------------------
        
        
        // Insert code here to initialize your application
        println("起動が完了しました")
        
 
        
    }

    /// アプリケーションが終了した
    //-------------------------------------------------------------------------------
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

