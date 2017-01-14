//
//  StaffListAPIProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebAPIFramework

protocol StaffListAPIProtocol: AlamofireProtocol {
    func getStaffs(completionHandler: @escaping ((Result<[Staff]>) -> Void)) -> Void
}

extension StaffListAPIProtocol {
    
    var baseURL: String {
        return "https://pyconjp.github.io/"
    }
    
    var path: String {
        return "pyconjp-android/stafflist.json"
    }
    
}

extension StaffListAPIProtocol {
    
    func getStaffs(completionHandler: @escaping ((Result<[Staff]>) -> Void)) -> Void {
        get() { result in
            switch result {
            case .success(let value):
                let staffList = value["staffList"] as? [[String: Any]] ?? []
                completionHandler(.success(staffList.map({ Staff(dictionary: $0) })))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        
        }
    }
    
}
