//
//  ViewController.swift
//  YjiPaster
//
//  Created by 季 雲 on 2017/11/17.
//  Copyright © 2017 Ericji. All rights reserved.
//

import UIKit
import SnapKit

let screen_width = UIScreen.main.bounds.width
let screen_height = UIScreen.main.bounds.height

class ViewController: UIViewController, StickerSelectDelegate {

    private let canvas = XTPasterStageView()
    private let scrollView = UIScrollView()
    private let scrollViewWidth = screen_width - 26
    private let appealVc = StickerViewController(collectionViewLayout: StickerLayout())
    private let likeVc = StickerViewController(collectionViewLayout: StickerLayout())
    private let characterVc = StickerViewController(collectionViewLayout: StickerLayout())
    private let typeVc = StickerViewController(collectionViewLayout: StickerLayout())
    private let visualVc = StickerViewController(collectionViewLayout: StickerLayout())
    
    private let appealSeg = SegmentButton(title: "アピール")
    private let likeSeg = SegmentButton(title: "好き")
    private let characterSeg = SegmentButton(title: "性格")
    private let typeSeg = SegmentButton(title: "タイプ")
    private let visualSeg = SegmentButton(title: "見た目")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = UIColor.yellow
        self.view.addSubview(canvas)
        canvas.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(screen_height/2)
        }
        
        let scrollBgView = ScrollBgV()
        self.view.addSubview(scrollBgView)
        scrollBgView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.bottom.equalTo(-10)
            make.height.equalTo(screen_height/3)
        }
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.left.equalTo(scrollBgView).offset(3)
            make.bottom.right.equalTo(scrollBgView).offset(-3)
        }
        
        appealVc.delegate = self
        scrollView.addSubview(appealVc.view)
        appealVc.view.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.height.equalTo(screen_height/3)
            make.width.equalTo(scrollViewWidth)
        }
        
        likeVc.delegate = self
        scrollView.addSubview(likeVc.view)
        likeVc.view.snp.makeConstraints { (make) in
            make.height.width.bottom.top.equalTo(appealVc.view)
            make.left.equalTo(appealVc.view.snp.right)
        }
        
        characterVc.delegate = self
        scrollView.addSubview(characterVc.view)
        characterVc.view.snp.makeConstraints { (make) in
            make.height.width.bottom.top.equalTo(appealVc.view)
            make.left.equalTo(likeVc.view.snp.right)
        }
        
        typeVc.delegate = self
        scrollView.addSubview(typeVc.view)
        typeVc.view.snp.makeConstraints { (make) in
            make.height.width.bottom.top.equalTo(appealVc.view)
            make.left.equalTo(characterVc.view.snp.right)
        }
        
        visualVc.delegate = self
        scrollView.addSubview(visualVc.view)
        visualVc.view.snp.makeConstraints { (make) in
            make.height.width.bottom.top.equalTo(appealVc.view)
            make.left.equalTo(typeVc.view.snp.right)
            make.right.equalToSuperview()
        }
        
        getAllStickers()
        
        appealSeg.onTapAction = { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: 0*(self?.scrollViewWidth)!, y: 0), animated: true)
        }
        self.view.addSubview(appealSeg)
        appealSeg.snp.makeConstraints { (make) in
            make.left.equalTo(scrollBgView)
            make.width.equalTo((screen_width-20-4*3)/5)
            make.bottom.equalTo(scrollBgView.snp.top).offset(-2)
            make.height.equalTo(40)
        }
        
        likeSeg.onTapAction = { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: 1*(self?.scrollViewWidth)!, y: 0), animated: true)
        }
        self.view.addSubview(likeSeg)
        likeSeg.snp.makeConstraints { (make) in
            make.left.equalTo(appealSeg.snp.right).offset(3)
            make.bottom.width.height.equalTo(appealSeg)
        }
        
        characterSeg.onTapAction = { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: 2*(self?.scrollViewWidth)!, y: 0), animated: true)
        }
        self.view.addSubview(characterSeg)
        characterSeg.snp.makeConstraints { (make) in
            make.left.equalTo(likeSeg.snp.right).offset(3)
            make.bottom.width.height.equalTo(appealSeg)
        }
        
        typeSeg.onTapAction = { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: 3*(self?.scrollViewWidth)!, y: 0), animated: true)
        }
        self.view.addSubview(typeSeg)
        typeSeg.snp.makeConstraints { (make) in
            make.left.equalTo(characterSeg.snp.right).offset(3)
            make.bottom.width.height.equalTo(appealSeg)
        }
        
        visualSeg.onTapAction = { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: 4*(self?.scrollViewWidth)!, y: 0), animated: true)
        }
        self.view.addSubview(visualSeg)
        visualSeg.snp.makeConstraints { (make) in
            make.left.equalTo(typeSeg.snp.right).offset(3)
            make.bottom.width.height.equalTo(appealSeg)
        }
        
        appealSeg.isSelected = true
        
    }
    
    private func getAllStickers() {
        let bundle = Bundle.main
        let urls = bundle.urls(forResourcesWithExtension: "png", subdirectory: "stickers")!
        appealVc.datasource = urls.filter{$0.lastPathComponent.contains("appeal")}
        characterVc.datasource = urls.filter{$0.lastPathComponent.contains("character")}
        likeVc.datasource = urls.filter{$0.lastPathComponent.contains("like")}
        typeVc.datasource = urls.filter{$0.lastPathComponent.contains("type")}
        visualVc.datasource = urls.filter{$0.lastPathComponent.contains("visual")}

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectedSticker(imgUrl: URL) {
        // get current image sticker
        if let image = UIImage(contentsOfFile: imgUrl.path) {
            canvas.addPaster(withImg: image)
        }
    }

}

