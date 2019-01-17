//
//  UIKitExtension.swift
//  ReactiveSwiftDemo
//
//  Created by roni on 2019/1/16.
//  Copyright © 2019 roni. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
