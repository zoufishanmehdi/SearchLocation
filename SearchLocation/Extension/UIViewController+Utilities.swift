//
//  UIViewController+Utilities.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/3/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func styleNavigationBar() {
        prefersLargeTitles = true
        isTranslucent = false
        tintColor = .white
        barTintColor = UIColor(red:0.22, green:0.41, blue:0.76, alpha:1.0)
        largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
