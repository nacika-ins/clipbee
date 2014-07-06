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
    
    // [[NSPasteboard generalPasteboard] clearContents];
    // [[NSPasteboard generalPasteboard] setString:helloField.stringValue  forType:NSStringPboardType];

}
