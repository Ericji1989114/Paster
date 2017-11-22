//
//  StickerViewController.swift
//  YjiPaster
//
//  Created by 季 雲 on 2017/11/17.
//  Copyright © 2017 Ericji. All rights reserved.
//

import UIKit


class StickerViewController: UICollectionViewController {
    
    weak var delegate: StickerSelectDelegate?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var datasource: [URL] = [] {
        willSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView!.register(StickerCell.self, forCellWithReuseIdentifier: StickerCell.cellId)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return datasource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCell.cellId, for: indexPath)
        if let cell = cell as? StickerCell {
            cell.set(imgUrl: datasource[indexPath.row])
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.selectedSticker(imgUrl: datasource[indexPath.row])
        }
    }


}
