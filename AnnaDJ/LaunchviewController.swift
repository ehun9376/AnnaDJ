//
//  LaunchPage.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation
import UIKit

class LaunchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pushToTabbarController()
    }
    

    
    func pushToTabbarController() {
        
        IAPCenter.shared.requestComplete = { [weak self] debug in
            if debug.count != 0{
                self?.showSingleAlert(title: "取得產品資料錯誤", message: debug.joined(separator: "\n"), confirmTitle: "OK", confirmAction: {
                    self?.toVC()
                })
            } else {
                self?.toVC()
            }

        }

        IAPCenter.shared.getProducts()


        
    }
    
    func toVC() {
        DispatchQueue.main.async {
            let scene = UIApplication.shared.connectedScenes.first
            
            if let delegate : SceneDelegate = (scene?.delegate as? SceneDelegate),
               let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: "NavigationVC"){
                delegate.window?.rootViewController = initialViewController
                delegate.window?.makeKeyAndVisible()
            }
        }
    }
    
}
