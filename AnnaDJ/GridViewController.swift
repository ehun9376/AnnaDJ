//
//  GridViewController.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/26.
//

import Foundation
import UIKit


class GridViewController: BaseCollectionViewController {
    
    var pleyers: MultipleAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.regisCell()
        self.pleyers = try? .init(filenames: IAPCenter.shared.types.map({$0.soundName}))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCollectionView()
        self.setupItemModel()
    }

    override func creatLayout() -> UICollectionViewFlowLayout {

        let layout = UICollectionViewFlowLayout()
        let width = self.view.frame.width / 4
        layout.itemSize = .init(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical

        return layout
    }
    
    func setupCollectionView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .blue
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
        ])
    }

    func setupItemModel() {

        var itemModels: [CollectionItemModel]? = []

        let width = self.view.frame.width / 4
        
        for (index,_) in IAPCenter.shared.types.enumerated() {
            itemModels?.append(ImageCellItemModel(color: UIColor(red: CGFloat(Float.random(in: 0...1)), green: CGFloat(Float.random(in: 0...1)), blue: CGFloat(Float.random(in: 0...1)), alpha: 1),
                                                  index: index,
                                                  itemSize: .init(width: width, height: width),
                                                  cellDidPressed: { [weak self] itemModel in
                guard let itemModel = itemModel as? ImageCellItemModel else { return }
                
                self?.pleyers?.play(index: itemModel.index ?? 0)
            }))
        }

        self.adapter?.updateData(itemModels: itemModels ?? [])
    }

    func regisCell(){
        self.collectionView.register(.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }


}
