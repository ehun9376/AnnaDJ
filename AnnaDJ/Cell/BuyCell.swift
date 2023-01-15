//
//  BuyCell.swift
//  AnnaDJ
//
//  Created by yihuang on 2023/1/15.
//

import Foundation
import UIKit

class BuyCellRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        return "BuyCell"
    }
    
    var title: String?
    
    var tryButtonAction: (()->())?
    
    var buyButtonAction: (()->())?
    
    init(title: String? = nil,
         tryButtonAction: (()->())? = nil,
         buyButtonAction: (()->())? = nil) {
        self.title = title
        self.tryButtonAction = tryButtonAction
        self.buyButtonAction = buyButtonAction
    }
}

class BuyCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tryButton: UIButton!
    
    @IBOutlet weak var buyButton: UIButton!
    
    var rowModel: BuyCellRowModel?
    
    override func awakeFromNib() {
        self.titleLabel.font = .systemFont(ofSize: 16)
        
        self.tryButton.addTarget(self, action: #selector(tryButtonAction), for: .touchUpInside)
        
        self.buyButton.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
        
        self.tryButton.setTitle("試聽", for: .normal)
        self.buyButton.setTitle("購買", for: .normal)
    }
    
    @objc func tryButtonAction() {
        self.rowModel?.tryButtonAction?()
    }
    
    @objc func buyButtonAction() {
        self.rowModel?.buyButtonAction?()
    }
     
}

extension BuyCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? BuyCellRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title

    }
}
