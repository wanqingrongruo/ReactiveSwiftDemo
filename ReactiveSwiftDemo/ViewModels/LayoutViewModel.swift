//
//  LayoutViewModel.swift
//  ReactiveSwiftDemo
//
//  Created by roni on 2019/1/16.
//  Copyright © 2019 roni. All rights reserved.
//

import Foundation
import UIKit

class LayoutViewModel {
    private let testModel: TestModel
    init(model: TestModel) {
        self.testModel = model
    }

    var headString: String { return testModel.headString }
    var nameString: String { return testModel.name }
    var titleString: String { return testModel.title }
    var contentString: String { return testModel.content }
    var illustrationString: String { return testModel.illustration }
    var url: URL {
        return Bundle.main.url(forResource: testModel.illustration, withExtension: "png")!
    }

    var image: UIImage?
}


let contents: [String] = {
    return ["text的计算是成本很高的，所以UIlabel的size通过text去控制计算开销成本会很高。这个时候我们可以 通过重写 UILabel 的 intrinsicContentSize 来直接控制它的固有尺寸。如果已知一个UILabel的展示size，直接重写其属性，其他情况使用", "有些控件比较特殊，比如 UIImageView，它的大小是根据他的image计算确定他的content size。UILabel是根据他的text确定的。这些都会返回它们的固有尺寸，UIView 会直接通过他们的固有尺寸来当做约束条件", "在设置约束的时候发生了什么事情呢？从下面的图中可以看到整体的一个结构。 有一个view 在window上，window上面有个叫做engine的内部对象，engine是autolayout计算的核心，当添加一个约束的时候，会创建一个Equation对象，然后会把equation对象添加到engine上，equation依据variables对象。", "render loop有很强的特定性，它的好处可以避免一些重复性的工作。但是它也很危险，因为它调用的频率会很高，是非常敏感的一段代码。"]
}()

class TestModel {
    var headString: String = "headIcon"
    var name: String
    var title: String
    var content: String
    var illustration: String


    init() {
        let randomNumber = Int.random(in: Int.min...Int.max)
        self.name = String(format: "roni%d", randomNumber)
        self.title = String(format: "title%d", randomNumber)
        self.content = contents[Int.random(in: 0...3)]
        self.illustration = String(describing: Int.random(in: 1...3))
    }
}
