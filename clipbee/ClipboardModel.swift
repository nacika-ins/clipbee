//
//  ClipboardModel.swift
//  clipbee
//
//  Created by nacika on 2014/06/14.
//  Copyright (c) 2014年 nacika. All rights reserved.
//

import Cocoa



class ClipboardModel: Model {
    
    struct Instances {
        static var instances: [ClipboardModel] = []
    }

    var text: String?


    /// 初期化
    //-------------------------------------------------------------------------------
    required init() {
        

        
        /// インスタンス生成
        //-------------------------------------------------------------------------------
        super.init()
        
    }
    
    /// 全てのインスタンスを取得
    //-------------------------------------------------------------------------------
    class func all () -> NSArray {
        return Instances.instances
    }
    
    /// カウント
    //-------------------------------------------------------------------------------
    class func count() -> Int {
        return Instances.instances.count
    }
    
    /// 指定した位置の要素を取得
    //-------------------------------------------------------------------------------
    class func findByIndex(index: Int) -> ClipboardModel {
        return Instances.instances[index]
    }
    
    /// 指定した数まで削除する
    //-------------------------------------------------------------------------------
    class func deleteOldHistory(num: Int) {
        while( Instances.instances.count >= num ) {
            Instances.instances.removeLast()
        }
    }
    
    /// インスタンスの追加 TODO: 将来的にこのクラスを 基底クラスに移動させる
    //-------------------------------------------------------------------------------
    class func create (text: String, limitNum: Int) -> ClipboardModel? {
        
        /// 空白は登録しない
        //-------------------------------------------------------------------------------
        if (text == "") {
            return nil
        }
        
        /// 重複したテキストを除外する
        //-------------------------------------------------------------------------------
        var count = 0
        for i in Instances.instances {
            if i.text == text {
                
                /// 重複した場合上に移動する
                //-------------------------------------------------------------------------------
                if (count != 0) {
                    Instances.instances.removeAtIndex(count)
                    self.create(text, limitNum: limitNum)
                }
                
                return nil
            }
            count += 1
        }
        
        /// 追加
        //-------------------------------------------------------------------------------
        var newInstance = self()
        newInstance.text = text
        Instances.instances.insert(newInstance, atIndex: 0)
        
        /// 多いデータを削除
        //-------------------------------------------------------------------------------
        self.deleteOldHistory(limitNum)
        
        
        return newInstance
    }



}
