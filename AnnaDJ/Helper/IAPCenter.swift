//
//  IAPCenter.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/12/2.
//

import Foundation
import StoreKit
enum ProductID {
    
    
    ///木魚
    case woodFish
    
    ///鼓
    case drum
    
    ///金剛鈴
    case ring
    
    ///引馨
    case inSin
    
    ///銅鑼
    case gong
    
    ///響板
    case board
    
    ///鐘
    case clock
    
    ///沙鈴
    case dotRing
    
    ///三角鐵
    case traingle
    
    case how
    
    case oh
    
    case airhorn
    
    case gminor
    
    case revCR
    
    case loops
    
    case fillin
    
    case tuneUp
    
    case acid
    
    case bass
    
    case crash
    
    case open
    
    case rootBPM
    
    case synths
    
    case kicks
    
    case snares
    
    var id: String  {
        switch self {
            //木魚
        case .woodFish: return  "com.gtarcade.lod.gold9"
            
            //鼓
        case .drum: return "b"
            
            //金剛鈴
        case .ring: return "com.proximabeta.tof.diamond6"
            
            //引馨
        case .inSin: return "d"
            
            //銅鑼
        case .gong: return "com.proximabeta.tof.diamond5"
            
        case .board: return "f"
            
        case .clock: return "g"
            
        case .dotRing: return "h"
            
        case .traingle: return "i"

        case .how:
            return "j"
        case .oh:
            return "n"
        case .airhorn:
            return "n"
        case .gminor:
            return "n"
        case .revCR:
            return "n"
        case .loops:
            return "com.moonton.diamond_5000_new"
        case .fillin:
            return "com.ngame.allstar.eu.pay99.99"
        case .tuneUp:
            return "com.ngame.allstar.naa.pay99.99"
        case .acid:
            return "10482"
        case .bass:
            return "10483"
        case .crash:
            return "60027"
        case .open:
            return "n"
        case .rootBPM:
            return "n"
        case .synths:
            return "n"
        case .kicks:
            return "n"
        case .snares:
            return "n"
        }
    }
    
    var text: String {
        switch self {
        case .woodFish:
            return "木魚"
        case .drum:
            return "鼓"
        case .ring:
            return "金剛鈴"
        case .inSin:
            return "引磬"
        case .gong:
            return "銅鑼"
        case .board:
            return "響板"
        case .clock:
            return "鐘"
        case .dotRing:
            return "沙鈴"
        case .traingle:
            return "三角鐵"
            
        case .how:
            return ""
        case .oh:
            return ""
        case .airhorn:
            return ""
        case .gminor:
            return ""
        case .revCR:
            return ""
        case .loops:
            return ""
        case .fillin:
            return ""
        case .tuneUp:
            return ""
        case .acid:
            return ""
        case .bass:
            return ""
        case .crash:
            return ""
        case .open:
            return ""
        case .rootBPM:
            return ""
        case .synths:
            return ""
        case .kicks:
            return ""
        case .snares:
            return ""
        }
    }
    
    var soundName: String {
        switch self {
        case .woodFish:
            return "woodFish"
        case .drum:
            return "drum"
        case .ring:
            return "ring"
        case .inSin:
            return "inSin"
        case .gong:
            return "gong"
        case .board:
            return "board"
        case .clock:
            return "clock"
        case .dotRing:
            return "dotRing"
        case .traingle:
            return "traingle"
        case .how:
            return "how"
        case .oh:
            return "oh"
        case .airhorn:
            return "airhorn"
        case .gminor:
            return "gminor"
        case .revCR:
            return "revCR"
        case .loops:
            return "loops"
        case .fillin:
            return "fillin"
        case .tuneUp:
            return "tuneUp"
        case .acid:
            return "acid"
        case .bass:
            return "bass"
        case .crash:
            return "crash"
        case .open:
            return "open"
        case .rootBPM:
            return "rootBPM"
        case .synths:
            return "synths"
        case .kicks:
            return "kicks"
        case .snares:
            return "snares"
        }
    }
    
}

class IAPCenter: NSObject {
    
    static let shared = IAPCenter()
    
    var products = [SKProduct]()
    
    var productRequest: SKProductsRequest?
    
    var requestComplete: (([String])->())?
    
    var storeComplete: (()->())?
    
    let baseTypes: [ProductID] = [.how,.oh,.clock,.airhorn,.gminor,.revCR,.drum,.board,.dotRing,.traingle]
    
    let buyTypes: [ProductID] = [
        .woodFish,
        .gong,
        .ring,
        .loops,
        .fillin,
        .tuneUp,
        .acid,
        .bass,
        .crash,
//        .open,
//        .rootBPM,
//        .synths,
//        .inSin,
//        .kicks,
//        .snares
    ]
    
    
    //總共有多少購買項目
    func getProductIDs() -> [String] {
        return buyTypes.map { $0.id }
    }
    
    func getProducts() {
        SKPaymentQueue.default().restoreCompletedTransactions()
        let productIds = getProductIDs()
        let productIdsSet = Set(productIds)
        productRequest = SKProductsRequest(productIdentifiers: productIdsSet)
        productRequest?.delegate = self
        productRequest?.start()
    }
    
    func buy(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            if let controller = window?.rootViewController as? BaseViewController {
                controller.showSingleAlert(title: "提示",
                                           message: "你的帳號無法購買",
                                           confirmTitle: "OK",
                                           confirmAction: nil)
            }
        }
    }
    
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
}
extension IAPCenter: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("產品列表")
        if response.products.count != 0 {
            response.products.forEach {
                print($0.localizedTitle, $0.price, $0.localizedDescription)
            }
            self.products = response.products
            requestComplete?([])
        } else {
            self.products = response.products
            requestComplete?(response.invalidProductIdentifiers)
            print(response.invalidProductIdentifiers)
            print(response.description)
            print(response.debugDescription)
        }
        
        
        
    }
    
}

extension IAPCenter: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print(error.localizedDescription)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        if let controller = window?.rootViewController as? BaseViewController {
            controller.showSingleAlert(title: "錯誤",
                                       message: error.localizedDescription,
                                       confirmTitle: "OK",
                                       confirmAction: nil)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        var iapedIDs = UserInfoCenter.shared.loadValue(.iaped) as? [String] ?? []
        
        transactions.forEach {
            
            print($0.payment.productIdentifier, $0.transactionState.rawValue)
            switch $0.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                print($0.error ?? "")
                if ($0.error as? SKError)?.code != .paymentCancelled {
                    // show error
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                SKPaymentQueue.default().finishTransaction($0)
            case .purchasing, .deferred:
                break
            @unknown default:
                break
            }
            
            if $0.transactionState == .purchased ||  $0.transactionState == .restored {
                
                if !iapedIDs.contains($0.payment.productIdentifier) {
                    iapedIDs.append($0.payment.productIdentifier)
                }
                
            }
            
        }
        UserInfoCenter.shared.storeValue(.iaped, data: iapedIDs)
        self.storeComplete?()
    }
    
}
