//
//  Timeline.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/07/21.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct Timeline {
    
    let key: String
    var talks: Array<TalkObject>
    
}

extension Timeline {
    
    init(key: String, talks: Array<TalkObject>?) {
        self.key = key
        self.talks = talks ?? [TalkObject]()
    }
    
    init(startTime: String, talks: Array<TalkObject>?) {
        self.key = startTime.timeStringByTrimingSecond()
        self.talks = talks ?? [TalkObject]()
    }
    
}
