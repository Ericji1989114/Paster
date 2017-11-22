//
//  StickerCell.swift
//  YjiPaster
//
//  Created by 季 雲 on 2017/11/17.
//  Copyright © 2017 Ericji. All rights reserved.
//

import UIKit

class StickerCell: UICollectionViewCell {
    
    static let cellId = "StickerCell"
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 5, 0, 5))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func set(imgUrl: URL) {
        let image = UIImage(contentsOfFile: imgUrl.path)
        imageView.image = image
    }

}
