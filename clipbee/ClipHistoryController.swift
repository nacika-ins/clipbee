//
//  ClipHistoryController.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa
import AppKit


/// 現在コピーされているテキストを表示するためのコントローラー
//-------------------------------------------------------------------------------
class ClipHistoryController: Controller, NSTableViewDataSource,NSTableViewDelegate {
    


    var dataArray = [
        [ "no": "aiueo", "copiedText": "kakikukeko" ]
    ]
    
    /// シングルトン
    /// @example var cm = ClipboardModel.sharedInstance
    //-------------------------------------------------------------------------------
    class var sharedInstance: ClipHistoryController {
    struct Singleton {
        static let instance = ClipHistoryController()
        }
        return Singleton.instance
    }
    
    /// リストに行がどのくらいあるのか返す
    //-------------------------------------------------------------------------------
    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int {
        return ClipboardModel.count()
    }
    
    /// テーブルビューの各セルに出力
    //-------------------------------------------------------------------------------
    func tableView(
        aTableView: NSTableView!,
        objectValueForTableColumn aTableColumn: NSTableColumn!,
        row rowIndex: Int) -> AnyObject!
    {
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        // println(aTableView, aTableColumn, rowIndex)
        
        // モデル
        //-------------------------------------------------------------------------------
        var m = ClipboardModel.find_by_index(rowIndex)
        
        // println(m.text)
        
        /// 選択させる
        //-------------------------------------------------------------------------------
        if aTableColumn.identifier == "no" {
            return rowIndex+1
        }
        else if aTableColumn.identifier == "copiedText" {
            return m.text
        }
        return ""
        
    }
    
    /// 追加
    //-------------------------------------------------------------------------------

}
