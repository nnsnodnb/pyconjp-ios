//
//  Category.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/04/27.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

struct Category {
    
    let id: Int
    let name: String
    
}

extension Category {
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
    
}
