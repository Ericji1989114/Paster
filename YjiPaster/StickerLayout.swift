//
//  StickerLayout.swift
//  YjiPaster
//
//  Created by 季 雲 on 2017/11/17.
//  Copyright © 2017 Ericji. All rights reserved.
//

import UIKit

class StickerLayout: UICollectionViewFlowLayout {
    
    private let padding: CGFloat = 10
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
        let imageSize: CGFloat = (screen_width - 6*padding)/5 // one line have five items
        self.itemSize = CGSize(width: imageSize, height: imageSize + 20)
        self.minimumLineSpacing = padding
        self.minimumInteritemSpacing = padding
        self.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
