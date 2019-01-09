//
//  CommonCell.swift
//  ReactiveSwiftDemo
//
//  Created by roni on 2019/1/8.
//  Copyright © 2019 roni. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class CommonCell: UITableViewCell {

    @IBOutlet weak var tLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var button: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func click(_ sender: Any) {
        for item in dataSource {
            item.isSelected.toggle()
            item.observe.send(value: item.isSelected)
            print(Unmanaged.passUnretained(item).toOpaque())
        }
        model?.isSelected.toggle()
        model?.observe.send(value: model?.isSelected ?? false)
        print(Unmanaged.passUnretained(model!).toOpaque())
    }

    private var model: DataModel?
    var dataSource = [DataModel]()
    func render(_ model: DataModel) {
        self.model = model
        tLabel.text = model.title
        detailLabel.text = model.content

        if model.isSelected {
            button.backgroundColor = .red
        } else {
            button.backgroundColor = .blue
        }

        model.signal.observeValues { [weak self](isSelected) in
            if isSelected {
                self?.button.backgroundColor = .red
            } else {
                self?.button.backgroundColor = .blue
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
