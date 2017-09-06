//
//  FloorMapZoomableImageViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class FloorMapZoomableImageViewController: ZoomableImageViewController {
    
    private var assetCatalog: AssetCatalog? {
        didSet {
            DispatchQueue.main.async {
                self.imageView?.image = self.assetCatalog?.image
            }
        }
    }
    
    static func build(assetCatalog: AssetCatalog) -> FloorMapZoomableImageViewController {
        let floorMapImageViewController: FloorMapZoomableImageViewController = UIStoryboard(storyboard: .more).instantiateViewController()
        floorMapImageViewController.assetCatalog = assetCatalog
        return floorMapImageViewController
    }
    
    enum AssetCatalog {
        case firstFloorView
        case secondFloorView
        case thirdFloorView
        case room201
        case room202
        case room203
        
        var title: String {
            switch self {
            case .firstFloorView: return "1F"
            case .secondFloorView: return "2F"
            case .thirdFloorView: return "3F"
            case .room201: return "Room 201"
            case .room202: return "Room 202"
            case .room203: return "Room 203"
            }
        }
        
        var image: UIImage {
            switch self {
            case .firstFloorView: return #imageLiteral(resourceName: "FirstFloorMap")
            case .secondFloorView: return #imageLiteral(resourceName: "SecondFloorMap")
            case .thirdFloorView: return #imageLiteral(resourceName: "ThirdFloorMap")
            case .room201: return #imageLiteral(resourceName: "Room201Map")
            case .room202: return #imageLiteral(resourceName: "Room202Map")
            case .room203: return #imageLiteral(resourceName: "Room203Map")
            }
        }
        
    }
    
}
