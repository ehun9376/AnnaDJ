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
        IAPCenter.shared.getProducts { [weak self] in
            self?.toVC()
        }
    }
    
    func toVC() {
        DispatchQueue.main.async {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationVC") {
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
}
