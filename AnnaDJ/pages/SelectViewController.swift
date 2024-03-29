//
//  SelectViewController.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation
import UIKit
import StoreKit
import AVFAudio

class SelectViewController: BaseTableViewController {
    
    var navigationtitle: String = ""
    
    var selectedModels: [CodeModel] = []
    
    var dataSourceModels: [CodeModel] = []
    
    var confirmAction: (([CodeModel])->())?
    
    var audioplayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.regisCellID(cellIDs: [
            "SettingCell",
            "BuyCell"
        ])
        self.setupRow()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "設定"
    }
    
    func setupRow() {
        
        var rowModels: [CellRowModel] = []
        
        
        
        for model in self.dataSourceModels {
            
            let buyRowModel = BuyCellRowModel(title: model.text ?? "",
                                              tryButtonAction: {  [weak self] in
                self?.tryListen(soundName: model.text ?? "")
            },
                                              buyButtonAction: {  [weak self] in
                if let id = model.data?.id {
                    self?.buy(id: id)
                }
            })
            
            rowModels.append(buyRowModel)
         
        }
        
        //恢復購買紀錄
        let reStoreRowModel = SettingCellRowModel(title: "恢復購買紀錄",
                                                imageName: "briefcase",
                                                showSwitch: false,
                                                cellDidSelect: { [weak self] _ in
            IAPCenter.shared.compelete = {
                self?.showToast(message: "購買紀錄已恢復")
            }
            IAPCenter.shared.restore()
            
        })
        
        rowModels.append(reStoreRowModel)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    
    func tryListen(soundName: String) {
        
        if let url = Bundle.main.url(forResource: soundName,
                                     withExtension: "mp3") {
            self.audioplayer = try? AVAudioPlayer(contentsOf: url)
        }
        
        if let audioplayer = self.audioplayer {
            if audioplayer.isPlaying {
                audioplayer.play()
            } else {
                audioplayer.play()
            }
            
        }
    }
    
    
    func buy(id: String) {
        
        if let product = IAPCenter.shared.products.first(where: {$0.productIdentifier == id}) {
            IAPCenter.shared.buy(product: product, compelete: { [weak self] in
                self?.setupRow()
            })
        } else {
            self.showToast(message: "取得產品資料錯誤")
        }
       
    }
    
}
