//
//  TestCell.swift
//  ReactiveSwiftDemo
//
//  Created by roni on 2019/1/16.
//  Copyright © 2019 roni. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        illustrationImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func render(viewModel: LayoutViewModel) {
        headImageView.image = UIImage(named: viewModel.headString)
        nameLabel.text = viewModel.nameString
        titleLabel.text = viewModel.titleString
        contentLabel.text = viewModel.contentString
        self.illustrationImageView.image = viewModel.image
    }

    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: VLabel!
    @IBOutlet weak var titleLabel: LLabel!
    @IBOutlet weak var contentLabel: LLabel!
    @IBOutlet weak var illustrationImageView: UIImageView!
}


class LLabel: UILabel {
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
//    }
}

class VLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 20)
    }
}
