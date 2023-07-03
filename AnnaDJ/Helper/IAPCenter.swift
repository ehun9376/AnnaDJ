//
//  IAPCenter.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/12/2.
//

import Foundation
import StoreKit

enum ProductID: CaseIterable {
    
    
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
        case .woodFish: return  ""
            
            //鼓
        case .drum: return ""
            
            //金剛鈴
        case .ring: return ""
            
            //引馨
        case .inSin: return ""
            
            //銅鑼
        case .gong: return ""
            
        case .board: return ""
            
        case .clock: return ""
            
        case .dotRing: return ""
            
        case .traingle: return ""

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
    
    var compelete: (()->())?
            
    var baseTypes: [SoundModel] = []
    
    var buyTypes: [SoundModel] = []
    
    
    
    func getProducts(compelete: (()->())?) {
        self.compelete = compelete

        

        SKPaymentQueue.default().restoreCompletedTransactions()
        


        //TODO: 透過後台把type變成活動的
        APIService.shared.requestWithParam(httpMethod: .post,
                                           urlText: .TinaDJTypeURL,
                                           param: [:],
                                           modelType: IAPModel.self) { jsonModel, error in

            self.baseTypes = jsonModel?.defaultType ?? []
            
            self.buyTypes = jsonModel?.canBuyType ?? []
             
            let productIds = self.buyTypes.map { $0.id }
            
            let productIdsSet = Set(productIds)
            self.productRequest = SKProductsRequest(productIdentifiers: productIdsSet)
            self.productRequest?.delegate = self
            self.productRequest?.start()
        }
  
    }
    
    func buy(product: SKProduct, compelete: (()->())?) {
        self.compelete = compelete
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
}
extension IAPCenter: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.compelete?()

        print("產品列表")
        if response.products.count != 0 {
            response.products.forEach {
                print($0.localizedTitle, $0.price, $0.localizedDescription)
            }
            self.products = response.products
        }
        
        
        
    }
    
}

extension IAPCenter: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        var iapedIDs = UserInfoCenter.shared.loadValue(.iaped) as? [String: Int] ?? [:]
        
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
                if var count = iapedIDs[$0.payment.productIdentifier] {
                    count += 1
                    iapedIDs[$0.payment.productIdentifier] = count
                } else {
                    iapedIDs[$0.payment.productIdentifier] = 1
                }
                
            }
            
        }
        UserInfoCenter.shared.storeValue(.iaped, data: iapedIDs)
    }
    
}
