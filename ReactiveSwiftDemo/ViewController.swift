//
//  ViewController.swift
//  ReactiveSwiftDemo
//
//  Created by roni on 2019/1/8.
//  Copyright © 2019 roni. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class DataModel {
    var title: String
    var content: String
    var isSelected: Bool

    let (signal, observe) = Signal<Bool, NoError>.pipe()

    init(title: String, content: String, isSelected: Bool) {
        self.title = title
        self.content = content
        self.isSelected = isSelected
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private lazy var dataSource: [DataModel] = {
        var array = [DataModel]()
        for i in 0...Int.random(in: 1...10) {
            let title = String(format: "title: %d", i)
            let content = String(format: "content: %d", i)
            let model = DataModel(title: title, content: content, isSelected: false)
            array.append(model)
        }
        return array
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UINib(nibName: "CommonCell", bundle: nil), forCellReuseIdentifier: "CommonCell")
        return tableView
    }()
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as! CommonCell

        let model = dataSource[indexPath.row]

        cell.dataSource = dataSource
        cell.render(model)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LayoutTestViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
