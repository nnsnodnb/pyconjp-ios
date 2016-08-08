//
//  TalksAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import RealmSwift

protocol TalksAPIType: AlamofireType {
    func getTalks(successClosure success: () -> Void, failClosure fail: (NSError) -> Void)
    func getTalksFromLocalDummyJson(successClosure success: () -> Void, failClosure fail: (NSError) -> Void)
}

extension TalksAPIType {
    
    var path: String {
        return "talks/list/"
    }
    
    func getTalks(successClosure success: () -> Void, failClosure fail: (NSError) -> Void) {
        get(nil, successClosure: { dictionary in
            let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
            
            do {
                let realm = try Realm()
                try realm.write({
                    presentations.forEach({
                        let talkObject = TalkObject(dictionary: $0)
                        realm.add(talkObject, update: true)
                    })
                })
                
                success()
            } catch let error as NSError {
                fail(error)
            }
            
        }, failClosure: { error in
            fail(error)
        })
    }
    
    func getTalksFromLocalDummyJson(successClosure success: () -> Void, failClosure fail: (NSError) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("DummyTalks", ofType: "json")
        let fileHandle = NSFileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! Dictionary<String, AnyObject>
        let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
        
        do {
            let realm = try Realm()
            try realm.write({
                presentations.forEach({
                    let talkObject = TalkObject(dictionary: $0)
                    realm.add(talkObject, update: true)
                })
            })
            
            success()
        } catch let error as NSError {
            fail(error)
        }
        
    }
    
}
