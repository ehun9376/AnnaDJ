//
//  ImageCell.swift
//  TintTint
//
//  Created by yihuang on 2022/10/20.
//

import Foundation
import UIKit

class ImageCellItemModel: CollectionItemModel {
    
    override func cellReUseID() -> String {
        return "ImageCell"
    }
        
    var color: UIColor?
    
    var index: Int?
        
    init(
        color: UIColor?,
        index: Int?,
        itemSize: CGSize? = nil,
        cellDidPressed: ((CollectionItemModel?) -> ())? = nil
    ) {
        super.init()
        self.color = color
        self.index = index
        self.itemSize = itemSize
        self.cellDidPressed = cellDidPressed
    }
}

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var backImageView: UIImageView!
        
    override func awakeFromNib() {
        self.backImageView.layer.cornerRadius = 5
        self.clipsToBounds = true
    }

}

extension ImageCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let itemModel = model as? ImageCellItemModel else { return }
        
        self.backImageView.backgroundColor = itemModel.color

    }
}
