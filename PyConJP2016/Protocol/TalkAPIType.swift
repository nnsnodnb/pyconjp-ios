//
//  TalkAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

protocol TalkAPIType: AlamofireType {
    //    func getTalks(parameter: Dictionary<String, AnyObject>?, successClosure success: (NSDictionary) -> Void, failClosure fail: (NSError) -> Void) -> Void
}

extension TalkAPIType {
    func getTalks(path: String, parameter: Dictionary<String, AnyObject>?, successClosure success: ([Talk]) -> Void, failClosure fail: (NSError) -> Void) {
        get(path, parameter: parameter, successClosure: { dictionary in
            let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? Array()
            
            let talks = presentations.map({
                Talk(dictionary: $0)
            })
            
            success(talks)
            
            }, failClosure: { error in
                
        })
    }
}
