//
//  ClipboardController.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa

/// クリックボードコントローラー
/// @note このコントローラではクリップボードを監視します。
//-------------------------------------------------------------------------------
class ClipboardController: Controller {
    
    /// プロパティの宣言
    //-------------------------------------------------------------------------------
    var nspaste: NSPasteboard
    
    /// シングルトン
    /// @example var cm = ClipboardModel.sharedInstance
    //-------------------------------------------------------------------------------
    class var sharedInstance: ClipboardController {
    struct Singleton {
        static let instance = ClipboardController()
        }
        return Singleton.instance
    }
    
    init(){
        
        /// クリップボード履歴インスタンス
        //-------------------------------------------------------------------------------
        self.nspaste = NSPasteboard.generalPasteboard()
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("初期化しました")
        
        
    }
    
    /// クリップボードを消す
    //-------------------------------------------------------------------------------
    func clearPasteBoard () {
        self.nspaste.clearContents()
    }
    
    /// クリップボードにテキストをコピーする
    //-------------------------------------------------------------------------------
    func setPasteBoard(text: String) {
        self.nspaste.setString("せばすやん", forType: NSPasteboardTypeString)
    }
    
    /// クリップボードの文字を取得する
    //-------------------------------------------------------------------------------
    func pasteBoardText() -> String {
        return self.nspaste.stringForType(NSPasteboardTypeString)
    }
    
    /// クリップボードの監視を行う
    //-------------------------------------------------------------------------------
    func clipboardCaptureStart() -> Bool {
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("クリップボードの監視を開始しました")
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        
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
        
        var loopCount = 0;
        
        /// appDelegate
        //-------------------------------------------------------------------------------
        let appDelegate = NSApplication.sharedApplication().delegate
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("スレッドが起動しました")
        
        while(true) {
            
            /// ループカウント
            //-------------------------------------------------------------------------------
            loopCount += 1;
            
            /// デバッグ
            //-------------------------------------------------------------------------------
            println("スレッドループ処理中です \(loopCount)")
            
            /// リストに追加
            //-------------------------------------------------------------------------------
            
            
            /// クリップボード履歴の取得
            //-------------------------------------------------------------------------------
            var clipText = self.pasteBoardText()
            
            
            /// 処理の待機
            //-------------------------------------------------------------------------------
            NSThread.sleepForTimeInterval(1.0)
        }
    }
    
    // [[NSPasteboard generalPasteboard] clearContents];
    // [[NSPasteboard generalPasteboard] setString:helloField.stringValue  forType:NSStringPboardType];

}
