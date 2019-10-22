//
//  StoryboardInstantiable.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstantiable: UIViewController {}

extension StoryboardInstantiable {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }

    static func instantiateWithNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! UINavigationController
    }
}

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}

