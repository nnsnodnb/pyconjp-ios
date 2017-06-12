//
//  UIImageViewExtension.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/13.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    @discardableResult
    func setImage(withURL url: URL?, placeholder: Image? = nil, imageTrainsition: ImageTransition = .noTransition) -> RetrieveImageTask {
        return self.kf.setImage(with: url,
                                placeholder: placeholder) { [weak self](image, _, _, _) in
                                    self?.run(imageTrainsition, with: image)
        }
    }
    
    private func run(_ imageTransition: ImageTransition, with image: Image?) {
        UIView.transition(
            with: self,
            duration: imageTransition.duration,
            options: imageTransition.animationOptions,
            animations: { imageTransition.animations(self, image) },
            completion: imageTransition.completion
        )
    }
    
}

extension UIImageView {
    
    /// Used to wrap all `UIView` animation transition options alongside a duration.
    enum ImageTransition {
        case noTransition
        case crossDissolve(TimeInterval)
        case curlDown(TimeInterval)
        case curlUp(TimeInterval)
        case flipFromBottom(TimeInterval)
        case flipFromLeft(TimeInterval)
        case flipFromRight(TimeInterval)
        case flipFromTop(TimeInterval)
        case custom(
            duration: TimeInterval,
            animationOptions: UIViewAnimationOptions,
            animations: (UIImageView, Image?) -> Void,
            completion: ((Bool) -> Void)?
        )
        
        /// The duration of the image transition in seconds.
        var duration: TimeInterval {
            switch self {
            case .noTransition:
                return 0.0
            case .crossDissolve(let duration):
                return duration
            case .curlDown(let duration):
                return duration
            case .curlUp(let duration):
                return duration
            case .flipFromBottom(let duration):
                return duration
            case .flipFromLeft(let duration):
                return duration
            case .flipFromRight(let duration):
                return duration
            case .flipFromTop(let duration):
                return duration
            case .custom(let duration, _, _, _):
                return duration
            }
        }
        
        /// The animation options of the image transition.
        var animationOptions: UIViewAnimationOptions {
            switch self {
            case .noTransition:
                return UIViewAnimationOptions()
            case .crossDissolve:
                return .transitionCrossDissolve
            case .curlDown:
                return .transitionCurlDown
            case .curlUp:
                return .transitionCurlUp
            case .flipFromBottom:
                return .transitionFlipFromBottom
            case .flipFromLeft:
                return .transitionFlipFromLeft
            case .flipFromRight:
                return .transitionFlipFromRight
            case .flipFromTop:
                return .transitionFlipFromTop
            case .custom(_, let animationOptions, _, _):
                return animationOptions
            }
        }
        
        /// The animation options of the image transition.
        var animations: ((UIImageView, Image?) -> Void) {
            switch self {
            case .custom(_, _, let animations, _):
                return animations
            default:
                return { $0.image = $1 }
            }
        }
        
        /// The completion closure associated with the image transition.
        var completion: ((Bool) -> Void)? {
            switch self {
            case .custom(_, _, _, let completion):
                return completion
            default:
                return nil
            }
        }
    }
    
}
