//
//  AppDelegate.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//


//
//  AppDelegate.swift
//  swift-test
//
//  Created by nacika on 2014/07/26.
//  Copyright (c) 2014年 nacika. All rights reserved.
//


import Cocoa
import Carbon

class AppDelegate: NSObject, NSApplicationDelegate {

    /// ウィンドウ
    //-------------------------------------------------------------------------------
    @IBOutlet weak var window: NSWindow!
    
    /// リストテーブル
    //-------------------------------------------------------------------------------
    @IBOutlet weak var clipHistoryTable : NSTableView!
    
    // クリップボード管理
    //-------------------------------------------------------------------------------
    var clipCon : ClipboardController!
    
    func getClipHistoryTable () -> NSTableView {
        return clipHistoryTable
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("起動が完了しました")
        
        /// デバッグとしてテストデータ追加
        //-------------------------------------------------------------------------------
        println("クリップボードモデルインスタンスの生成を行います")
        // ClipboardModel.create("クリップボードの内容1")
        // ClipboardModel.create("クリップボードの内容1")
        // ClipboardModel.create("クリップボードの内容2")
        // ClipboardModel.create("クリップボードの内容2")
        // ClipboardModel.create("クリップボードの内容3")
        
        
        /// クリップボードコントローラインスタンスの取得
        //-------------------------------------------------------------------------------
        clipCon = ClipboardController.sharedInstance
        
        
        
        /// クリップボードの監視を行う
        //-------------------------------------------------------------------------------
        println("クリップボードの監視を行います")
        clipCon.clipboardCaptureStart()
        
        /// ホットキー設定
        //-------------------------------------------------------------------------------
        registerHotKeys()
        
        /// イベントモニタリング
        //-------------------------------------------------------------------------------
        eventWatch()
        
        /// メインウィンドウを非表示にする
        //-------------------------------------------------------------------------------
        window.orderOut(self)
        
        /// デバッグ
        //-------------------------------------------------------------------------------
        println("起動が完了しました")
        
    }
    
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "nacika.swift_test" in the user's Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        let appSupportURL = urls[urls.count - 1] as NSURL
        return appSupportURL.URLByAppendingPathComponent("nacika.swift_test")
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("swift_test", withExtension: "momd")
        return NSManagedObjectModel(contentsOfURL: modelURL)
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.) This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        let fileManager = NSFileManager.defaultManager()
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        
        // Make sure the application files directory is there
        let properties = self.applicationDocumentsDirectory.resourceValuesForKeys([NSURLIsDirectoryKey], error: &error)
        if properties {
            if !properties[NSURLIsDirectoryKey]?.boolValue {
                failureReason = "Expected a folder to store application data, found a file \(self.applicationDocumentsDirectory.path)."
            }
        } else if error!.code == NSFileReadNoSuchFileError {
            error = nil
            fileManager.createDirectoryAtPath(self.applicationDocumentsDirectory.path, withIntermediateDirectories: true, attributes: nil, error: &error)
        }
        
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator?
        if !error {
            coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("swift_test.storedata")
            if coordinator!.addPersistentStoreWithType(NSXMLStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
                coordinator = nil
            }
        }
        
        if error {
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError.errorWithDomain("YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSApplication.sharedApplication().presentError(error)
            return nil
        } else {
            return coordinator
        }
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if !coordinator {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving and Undo support
    
    @IBAction func saveAction(sender: AnyObject!) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        if let moc = self.managedObjectContext {
            if !moc.commitEditing() {
                NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing before saving")
            }
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                NSApplication.sharedApplication().presentError(error)
            }
        }
    }
    
    func windowWillReturnUndoManager(window: NSWindow!) -> NSUndoManager! {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        if let moc = self.managedObjectContext {
            return moc.undoManager
        } else {
            return nil
        }
    }
    
    func applicationShouldTerminate(sender: NSApplication!) -> NSApplicationTerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        
        if let moc = managedObjectContext {
            if !moc.commitEditing() {
                NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing to terminate")
                return .TerminateCancel
            }
            
            if !moc.hasChanges {
                return .TerminateNow
            }
            
            var error: NSError? = nil
            if !moc.save(&error) {
                // Customize this code block to include application-specific recovery steps.
                let result = sender.presentError(error)
                if (result) {
                    return .TerminateCancel
                }
                
                let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
                let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
                let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
                let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
                let alert = NSAlert()
                alert.messageText = question
                alert.informativeText = info
                alert.addButtonWithTitle(quitButton)
                alert.addButtonWithTitle(cancelButton)
                
                let answer = alert.runModal()
                if answer == NSAlertFirstButtonReturn {
                    return .TerminateCancel
                }
            }
        }
        // If we got here, it is time to quit.
        return .TerminateNow
    }
    
    
    /// <##>
    //-------------------------------------------------------------------------------
    func pasteText ( item : NSMenuItem ) {
        var num : Int = item.keyEquivalent.toInt()!
        var clipHistory : Array = ClipboardModel.all()
        var clip = clipHistory[num] as ClipboardModel
        var text = clip.text
        ClipboardController.sharedInstance.setPasteBoard(text!)
        ClipboardController.sharedInstance.pushPasteKeyboard()
        
        
    }

    // <##>
    //-------------------------------------------------------------------------------
    
    
    /// ポップアップを出す
    //-------------------------------------------------------------------------------
    func showPopup (event: NSEvent) {
        
        
        /// マウス座標取得
        //-------------------------------------------------------------------------------
        var mouseLocation : NSPoint = NSEvent.mouseLocation()
        var frame : NSRect = NSMakeRect(mouseLocation.x, mouseLocation.y, 200, 200)
        
        /// 透明なウィンドウを作成
        //-------------------------------------------------------------------------------
        var newWindow : NSWindow = NSWindow(contentRect: frame, styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        newWindow.alphaValue = 0
        var windowBacking = newWindow.convertRectToBacking(frame)
        
        /// 位置情報
        //-------------------------------------------------------------------------------
        var location : NSPoint = NSPoint(x: 0, y: 0)
        var origin : NSPoint = NSPoint(x: 10, y: 20)
        
        /// 偽のマウスイベント
        //-------------------------------------------------------------------------------
        var eventType = NSEventType.LeftMouseDown
        var mouseEvent :NSEvent = NSEvent.mouseEventWithType(eventType, location: location, modifierFlags: nil, timestamp: 0, windowNumber: newWindow.windowNumber, context: nil, eventNumber: 0, clickCount: 0, pressure: 0)

        
        /// メニュー作成
        //-------------------------------------------------------------------------------
        var menuView = NSView(frame: NSRect(x: 100, y: 10, width: 100, height: 100))
        menuView.frame.origin.x = 100
        menuView.frame.origin.y = 100
        menuView.bounds.contains(CGRectMake(10, 20, 30, 40))
        var menu = CustomMenu(title: "Menu")
        var sel = Selector("pasteText:")
        
        /// メニューアイテム作成
        //-------------------------------------------------------------------------------
        var clipHistory = ClipboardModel.all()
        var count : Int = 0
        for i in clipHistory {
            var clip : ClipboardModel = i as ClipboardModel
            menu.insertItemWithTitle(clip.text, action: sel, keyEquivalent: String(count), atIndex: count)
            count += 1
        }
        
        

        
        /// ポップアップ表示
        //-------------------------------------------------------------------------------
        CustomMenu.popUpContextMenu(menu, withEvent: mouseEvent, forView: menuView)
    }
    
    
    /// イベントの監視を行う アクセシビリティの許可が必要です。
    //-------------------------------------------------------------------------------
    func eventWatch () {
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: { (event: NSEvent!) -> Void in
            // cmd + B
            // println(event.keyCode)
            
            // cmdkey
            var commandKeyPressed = (event.modifierFlags & NSEventModifierFlags.CommandKeyMask)
            if  ( event.keyCode == 11 && commandKeyPressed ) {
                println("イベントキャッチ") 
                NSApp.activateIgnoringOtherApps(true)
                self.showPopup(event)
            }
        } )
        println("イベントの監視を開始しました")
    }
    
    
    /// ホットキー設定
    //-------------------------------------------------------------------------------
    enum kEventHotKey: Int {
        case PressedSubtype = 6
        case ReleasedSubtype = 9
    }
    
    
    /// CarbonAPI TODO: 未完成だが、いずれ使用できなくなる
    //-------------------------------------------------------------------------------
    func registerHotKeys (){
        
        var gMyHotKeyRef: Unmanaged<EventHotKeyRef>?
        var gMyHotKeyID: EventHotKeyID = EventHotKeyID( signature: OSType(FourCharCode(UInt32(UInt(0x1243)))), id: 1 )
        var eventType: EventTypeSpec = EventTypeSpec( eventClass: OSType(FourCharCode(UInt32(UInt(kEventClassKeyboard)))), eventKind: UInt32(UInt(kEventHotKeyPressed)) )
        // var applicationEventTarget: EventTarget = GetApplicationEventTarget() as EventTarget
        
        // var err : OSStatus = InstallApplicationEventHandler(&globalHotkeyHandler, 1, &eventType, nil, nil)
        
        // RegisterEventHotKey(20, UInt32(cmdKey), gMyHotKeyID, GetApplicationEventTarget(), 0, &gMyHotKeyRef)
        // var state = RegisterEventHotKey(49, UInt32(cmdKey), gMyHotKeyID, applicationEventTarget, 0, &gMyHotKeyRef)
        // println("ホットキーを登録しました")
        // println(state)
    }
    
    func sendEvent (event: NSEvent) {
        println("Hotkey!!!")
        // if (event.subtype == kEventHotKey.PressedSubtype) {
        // }
    }
    
    func globalHotkeyHandler(nextHandler: EventHandlerCallRef, anEvent: EventRef, userData: Void) -> OSStatus {
        println("global!!!")
        return Int32(0)
    }

    
}
