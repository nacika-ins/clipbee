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
    
    var a = ""
    
    
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
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("初期化しました")
        
        
        nspaste = NSPasteboard.generalPasteboard()
        var targetType = nspaste.availableTypeFromArray([NSPasteboardTypeString])
        var b = nspaste.stringForType(targetType)
        


        
        
    }
    
    /// クリップボードを消す
    //-------------------------------------------------------------------------------
    func clearPasteBoard () {
        self.nspaste.clearContents()
    }
    
    /// クリップボードにテキストをコピーする (ClearContentしてからでないと挿入できない)
    //-------------------------------------------------------------------------------
    func setPasteBoard(text: String) {
        self.nspaste.clearContents()
        self.nspaste.setString(text, forType: NSPasteboardTypeString)
        
    }
    
    
    
    // ペーストボタンを押す
    //-------------------------------------------------------------------------------
    func pushPasteKeyboard () {
        
        /// 非アクティブ化
        //-------------------------------------------------------------------------------
        var app: NSApplication = NSApplication.sharedApplication()
        app.hide(nil)
        app.unhideWithoutActivation()
        var ws : NSWorkspace = NSWorkspace.sharedWorkspace()
        var frontMostApp = ws.frontmostApplication
        frontMostApp.unhide()

        
        // var delegate: AppDelegate = app.delegate as AppDelegate
        // var windowList = CGWindowListCopyWindowInfo(CGWindowListOption(kCGWindowListOptionOnScreenOnly), CGWindowID(0)).takeRetainedValue().__conversion()
        // println(windowList)
        // var activeApp = delegate.activeApp
        // var activeAppName : String?
        // var activeAppPath : NSURL?
        // var activeAppIdentifier : String?
        
        
        // for i in activeApp {
        //     if i.0 == "NSApplicationName" {
        //         activeAppName = i.1 as? String
        //     }
        //     if i.0 == "NSApplicationPath" {
        //         activeAppPath = i.1 as? NSURL
        //     }
        //     if i.0 == "NSApplicationBundleIdentifier" {
        //         activeAppIdentifier = i.1 as? String
        //     }
        // }
        
        // println( activeApp )
        
        //ws.launchApplicationAtURL(activeAppPath, options: nil, configuration: nil, error: nil)
        
        // var targetDesc : NSAppleEventDescriptor = NSAppleEventDescriptor.nullDescriptor();
        // ws.launchAppWithBundleIdentifier(activeAppIdentifier, options: nil, additionalEventParamDescriptor: targetDesc, launchIdentifier: nil)
        

        
        var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0 * NSEC_PER_MSEC));
        dispatch_after(popTime, dispatch_get_main_queue(), {() in
            
            println("🔥🔥🔥🔥 発火 🔥🔥🔥🔥")
            
            
            
            // var location : NSPoint = NSEvent.mouseLocation()
            
            // var mouseDown : CGEvent = CGEventCreateMouseEvent(nil, kCGEventLeftMouseDown, location, 0).takeUnretainedValue()
            // CGEventPost(UInt32(kCGHIDEventTap), mouseDown)
            
            // var mouseUp : CGEvent = CGEventCreateMouseEvent(nil, kCGEventLeftMouseUp, location, 0).takeUnretainedValue()
            // CGEventPost(UInt32(kCGHIDEventTap), mouseUp)
            
            var keyVDown : CGEvent = CGEventCreateKeyboardEvent (nil, CGKeyCode(9), true).takeUnretainedValue()
            CGEventSetFlags(keyVDown, UInt64(kCGEventFlagMaskCommand))
            CGEventPost(UInt32(kCGHIDEventTap), keyVDown)
            
            var keyVUp : CGEvent = CGEventCreateKeyboardEvent (nil, CGKeyCode(9), false).takeUnretainedValue()
            CGEventSetFlags(keyVUp, UInt64(kCGEventFlagMaskCommand))
            CGEventPost(UInt32(kCGHIDEventTap), keyVUp)
            
        })
        
    }
    
    /// クリップボードの文字を取得する
    //-------------------------------------------------------------------------------
    func pasteBoardText() -> String {
        return nspaste.stringForType(NSStringPboardType)
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
        NSThread.detachNewThreadSelector("clipboardWatcher", toTarget: self, withObject: nil)
        
        return true
        
    }
    
    /// クリップボード監視処理
    //-------------------------------------------------------------------------------
    func clipboardWatcher() {
        
        var loopCount = 0;
        var clipText: String?
        
        /// appDelegate
        //-------------------------------------------------------------------------------
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate

        
        /// <##>
        //-------------------------------------------------------------------------------
        let clipcon = ClipboardController.sharedInstance
        
        let clipTable = appDelegate.clipHistoryTable
        clipTable.setNeedsDisplay()
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("スレッドが起動しました")
        
        while(true) {
            
            /// ループカウント
            //-------------------------------------------------------------------------------
            loopCount += 1;
            
            
            /// クリップボード履歴の取得
            //-------------------------------------------------------------------------------
            clipText = self.pasteBoardText()
            
            /// リストに追加
            //-------------------------------------------------------------------------------
            ClipboardModel.create(clipText!)
            
            /// リスト更新 (while実行中の場合は、Windowがアクティブでないと更新されない)
            //-------------------------------------------------------------------------------
            // clipTable.reloadData()
            
            /// デバッグ
            //-------------------------------------------------------------------------------
            // println("スレッドループ処理中です \(loopCount) \(clipText!) \(ClipboardModel.count())")
            
            /// 処理の待機
            //-------------------------------------------------------------------------------
            NSThread.sleepForTimeInterval(0.5)
        }
    }
    
    // [[NSPasteboard generalPasteboard] clearContents];
    // [[NSPasteboard generalPasteboard] setString:helloField.stringValue  forType:NSStringPboardType];

}
