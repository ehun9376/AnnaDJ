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
        self.view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCollectionView()
        self.setupItemModel()
        self.setupRightButton()
        self.setupLeftButton()
    }
    
    func setupRightButton() {
        
        let set = UIBarButtonItem(title: "設定", style: .plain, target: self, action: #selector(rightButtonAction))

        self.navigationItem.rightBarButtonItems = [set]

    }
    
    func setupLeftButton() {
        
        let stop = UIBarButtonItem(title: "全部停止播放", style: .plain, target: self, action: #selector(leftButtonAction))

        self.navigationItem.leftBarButtonItems = [stop]

    }
    
    @objc func leftButtonAction() {
        self.pleyers?.stop()
    }
    
    @objc func rightButtonAction() {
        let vc = SelectViewController()
        
        var codeDataSource: [CodeModel] = []
        
                        
        let buyedTypes = IAPCenter.shared.buyTypes
        
        for (index,type) in buyedTypes.enumerated() {
            codeDataSource.append(CodeModel(text: type.title, number: index, data: type))
        }
        
        vc.dataSourceModels = codeDataSource
        
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.collectionView.backgroundColor = .black
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
        
        
        let iaped = UserInfoCenter.shared.loadValue(.iaped) as? [String:Int] ?? [:]
        
        var alltype = IAPCenter.shared.baseTypes
                
        let buyedTypes = IAPCenter.shared.buyTypes.filter({ return iaped[$0.id] ?? 0 >= 1 })
        
        //購買過的
        alltype.append(contentsOf: buyedTypes)
        
        
        //測試用全部
//        alltype.append(contentsOf: IAPCenter.shared.buyTypes)

        
        self.pleyers = try? .init(keyFilenames: alltype.map({$0.title}))
        
        for (index,type) in alltype.enumerated() {
            itemModels?.append(ImageCellItemModel(title: type.title,
                                                  color: UIColor(red: CGFloat(Float.random(in: 0...1)),
                                                                 green: CGFloat(Float.random(in: 0...1)),
                                                                 blue: CGFloat(Float.random(in: 0...1)),
                                                                 alpha: 1),
                                                  index: index,
                                                  itemSize: .init(width: width, height: width),
                                                  cellDidPressed: { [weak self] itemModel in
                
                self?.pleyers?.play(id: type.title)
                
                var iaped = UserInfoCenter.shared.loadValue(.iaped) as? [String: Int] ?? [:]
                
                if var count = iaped[type.id] {
                    count -= 1
                    if count <= 0 {
                        count = 0
                    }
                    iaped[type.id] = count
                }
                UserInfoCenter.shared.storeValue(.iaped, data: iaped)
                self?.setupItemModel()
            }))
        }

        self.adapter?.updateData(itemModels: itemModels ?? [])
    }

    func regisCell(){
        self.collectionView.register(.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }


}
