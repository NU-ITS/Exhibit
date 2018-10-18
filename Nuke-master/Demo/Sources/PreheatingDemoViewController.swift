// The MIT License (MIT)
//
// Copyright (c) 2015-2018 Alexander Grebenyuk (github.com/kean).

import UIKit
import Nuke
import Preheat

private let cellReuseID = "reuseID"
private var loggingEnabled = false

final class PreheatingDemoViewController: UICollectionViewController {
    var photos: [URL]!

    var preheater: ImagePreheater!
    var preheatController: Preheat.Controller<UICollectionView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        photos = demoPhotosURLs

        preheater = ImagePreheater()
        preheatController = Preheat.Controller(view: collectionView!)
        preheatController.handler = { [weak self] addedIndexPaths, removedIndexPaths in
            self?.preheat(added: addedIndexPaths, removed: removedIndexPaths)
        }

        collectionView?.backgroundColor = UIColor.white
        if #available(iOS 10.0, *) {
            collectionView?.isPrefetchingEnabled = false
        }
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
    }

    func preheat(added: [IndexPath], removed: [IndexPath]) {
        func urls(for indexPaths: [IndexPath]) -> [URL] {
            return indexPaths.map { photos[$0.row] }
        }
        preheater.startPreheating(with: urls(for: added))
        preheater.stopPreheating(with: urls(for: removed))
        if loggingEnabled {
            logAddedIndexPaths(added, removedIndexPaths: removed)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateItemSize()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        preheatController.enabled = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        preheatController.enabled = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateItemSize()
    }

    func updateItemSize() {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        let itemsPerRow = 4
        let side = (Double(view.bounds.size.width) - Double(itemsPerRow - 1) * 2.0) / Double(itemsPerRow)
        layout.itemSize = CGSize(width: side, height: side)
    }

    // MARK: UICollectionView

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath)
        cell.backgroundColor = UIColor(white: 235.0 / 255.0, alpha: 1.0)

        let imageView = self.imageView(for: cell)
        let imageURL = photos[indexPath.row]

        Nuke.loadImage(
            with: imageURL,
            options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)),
            into: imageView
        )

        return cell
    }

    func imageView(for cell: UICollectionViewCell) -> UIImageView {
        var imageView = cell.viewWithTag(15) as? UIImageView
        if imageView == nil {
            imageView = UIImageView(frame: cell.bounds)
            imageView!.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
            imageView!.tag = 15
            imageView!.contentMode = .scaleAspectFill
            imageView!.clipsToBounds = true
            cell.addSubview(imageView!)
        }
        return imageView!
    }
}

private func logAddedIndexPaths(_ addedIndexPath: [IndexPath], removedIndexPaths: [IndexPath]) {
    func stringForIndexPaths(_ indexPaths: [IndexPath]) -> String {
        guard indexPaths.count > 0 else {
            return "[]"
        }
        let items = indexPaths
            .map { return "\(($0 as NSIndexPath).item)" }
            .joined(separator: " ")
        return "[\(items)]"
    }
    print("did change preheat rect with added indexes \(stringForIndexPaths(addedIndexPath)), removed indexes \(stringForIndexPaths(removedIndexPaths))")
}
