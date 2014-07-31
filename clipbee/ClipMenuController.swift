//
//  ClipMenuController.swift
//  clipbee
//
//  Created by nacika on 2014/07/27.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa

class ClipMenuController: Controller {

    var clipMenu: NSMenu
    
    init () {
        

        /// メニューの作成
        //-------------------------------------------------------------------------------
        clipMenu = NSMenu()
        
        
        super.init()        
        
    }    
    
    func addMenu () {
        

        clipMenu.insertItemWithTitle("100x100", action: nil, keyEquivalent: nil, atIndex: 0)
    }
    
    func showMenu () {
        NSMenu.popUpContextMenu(self.clipMenu, withEvent: nil, forView: nil)
    }
    
    func selectHistory () -> String {
        return ""
    }
}
