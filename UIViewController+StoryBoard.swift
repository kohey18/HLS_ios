//
//  UIViewController+StoryBoard.swift
//  GNChannel
//
//  Created by kohey on 2015/11/22.
//  Copyright © 2015年 kohey. All rights reserved.
//

import UIKit

extension UIViewController {
    class func gn_instantiateViewControllerFromStoryboard(bundle: NSBundle? = nil, storyboardName: String, storyboardIdentifier: String, context: [String: AnyObject]? = nil) -> UIViewController? {
        var viewController: UIViewController? = nil
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        viewController = storyboard.instantiateViewControllerWithIdentifier(storyboardIdentifier) as? UIViewController
        //viewController?.rmp_bindContext(context)
        return viewController
    }
}
