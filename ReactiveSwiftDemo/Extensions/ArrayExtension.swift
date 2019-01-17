//
//  ArrayExtension.swift
//  ReactiveSwiftDemo
//
//  Created by roni on 2019/1/16.
//  Copyright © 2019 roni. All rights reserved.
//

import Foundation

public extension Array {
    public subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : .none
    }
}
