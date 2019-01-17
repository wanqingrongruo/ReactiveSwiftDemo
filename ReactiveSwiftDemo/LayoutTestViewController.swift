//
//  LayoutTestViewController.swift
//  ReactiveSwiftDemo
//
//  Created by roni on 2019/1/16.
//  Copyright © 2019 roni. All rights reserved.
//

import UIKit

class LayoutTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        view.addSubview(tableView)
    }

    var cacheImages = [String: UIImage]()
    let serialQueue = DispatchQueue(label: "Decode queue")

    private lazy var dataSource: [LayoutViewModel] = {
        var array = [LayoutViewModel]()
        for i in 0...Int.random(in: 1...50) {
            let model = TestModel()
            let vm = LayoutViewModel(model: model)
            array.append(vm)
        }
        return array
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UINib(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
}


extension LayoutTestViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        let viewModel = dataSource[indexPath.row]
        cell.render(viewModel: viewModel)

        if viewModel.image == nil  {
            serialQueue.async {
                self.downloadImage(at: indexPath)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let viewModel = dataSource[indexPath.row]
            if viewModel.image == nil {
                serialQueue.async {
                    self.downloadImage(at: indexPath)
                }
            }
        }
    }

    func downloadImage(at indexPath: IndexPath) {
        let downSampleImage = self.downsample(imageAt: self.dataSource[indexPath.row].url, to: CGSize(width: 564, height: 564), scale: 1)
        DispatchQueue.main.async {
            self.update(at: indexPath, with: downSampleImage)
        }
    }

    func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        let sourceOpt = [kCGImageSourceShouldCache : false] as CFDictionary
        let source = CGImageSourceCreateWithURL(imageURL as CFURL, sourceOpt)!

        let maxDimension = max(pointSize.width, pointSize.height) * scale
        let downsampleOpt = [kCGImageSourceCreateThumbnailFromImageAlways : true,
                             kCGImageSourceShouldCacheImmediately : true ,
                             kCGImageSourceCreateThumbnailWithTransform : true,
                             kCGImageSourceThumbnailMaxPixelSize : maxDimension] as CFDictionary
        let downsampleImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOpt)!
        return UIImage(cgImage: downsampleImage)
    }

    func update(at indexPath: IndexPath, with image: UIImage) {
        let vm = self.dataSource[indexPath.row]
        vm.image = image
        self.dataSource[indexPath.row] = vm

        if cacheImages[vm.url.absoluteString] == nil {
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.reloadRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
            }
        }

        cacheImages[vm.url.absoluteString] = image
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -100 {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
