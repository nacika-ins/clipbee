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
    
    
    init(){
        
        /// クリップボード履歴インスタンス
        //-------------------------------------------------------------------------------
        self.nspaste = NSPasteboard.generalPasteboard()
        
        /// クリップボード履歴を消す
        //-------------------------------------------------------------------------------
        self.nspaste.clearContents()
        
        /// クリップボードを設定する
        //-------------------------------------------------------------------------------
        self.nspaste.setString("せばすやん", forType: NSPasteboardTypeString)
        
        /// クリップボードの文字を取得する
        //-------------------------------------------------------------------------------
        var hoge = self.nspaste.stringForType(NSPasteboardTypeString)
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println(hoge)
        
        

        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("初期化しました")
        
        
    }
    


    
    
    // [[NSPasteboard generalPasteboard] clearContents];
    // [[NSPasteboard generalPasteboard] setString:helloField.stringValue  forType:NSStringPboardType];

}
