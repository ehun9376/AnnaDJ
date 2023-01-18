//
//  CodeModel.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation

class CodeModel: Equatable {
    public static func == (lhs: CodeModel, rhs: CodeModel) -> Bool {
        return lhs.text == rhs.text
        && lhs.text == rhs.text
    }
    
    var text: String?
    
    var number: Int?
    
    var data: ProductID = .woodFish
    
    init(text: String? = nil, number: Int? = nil, data: ProductID) {
        self.text = text
        self.number = number
        self.data = data
    }
    
    
    
    static let how: CodeModel = .init(text: ProductID.how.text, number: 0, data: .how)
    
    static let oh: CodeModel = .init(text: ProductID.oh.text, number: 1, data: .oh)
    
    static let airhorn: CodeModel = .init(text: ProductID.airhorn.text, number: 2, data: .airhorn)
    
    static let gminor: CodeModel = .init(text: ProductID.gminor.text, number: 3, data: .gminor)
    
    static let revCR: CodeModel = .init(text: ProductID.revCR.text, number: 4, data: .revCR)
    
    static let loops: CodeModel = .init(text: ProductID.loops.text, number: 5, data: .loops)
    
    static let fillin: CodeModel = .init(text: ProductID.fillin.text, number: 6, data: .fillin)
    
    static let tuneUp: CodeModel = .init(text: ProductID.tuneUp.text, number: 7, data: .tuneUp)
    
    static let acid: CodeModel = .init(text: ProductID.acid.text, number: 8, data: .acid)
    
    static let bass: CodeModel = .init(text: ProductID.bass.text, number: 9, data: .bass)
    
    static let crash: CodeModel = .init(text: ProductID.crash.text, number: 10, data: .crash)
    
    static let open: CodeModel = .init(text: ProductID.open.text, number: 11, data: .open)
    
    static let rootBPM: CodeModel = .init(text: ProductID.rootBPM.text, number: 12, data: .rootBPM)
    
    static let synths: CodeModel = .init(text: ProductID.synths.text, number: 13, data: .synths)
    
    static let kicks: CodeModel = .init(text: ProductID.kicks.text, number: 14, data: .kicks)
    
    static let snares: CodeModel = .init(text: ProductID.snares.text, number: 15, data: .snares)
    
    static let woodFish: CodeModel = .init(text: ProductID.woodFish.text, number: 16, data: .woodFish)
    
    static let gong: CodeModel = .init(text: ProductID.gong.text, number: 17, data: .gong)
    
    static let ring: CodeModel = .init(text: ProductID.ring.text, number: 18, data: .ring)
    
 
    static let items: [CodeModel] = [
        .woodFish,
        .gong,
        .ring,
        .loops,
        .fillin,
        .tuneUp,
        .acid,
        .bass,
        .crash
    ]
    
//    static let items: [CodeModel] = [
//        .how,
//        .oh,
//        .airhorn,
//        .gminor,
//        .revCR,
//        .loops,
//        .fillin,
//        .tuneUp,
//        .acid,
//        .bass,
//        .crash,
//        .open,
//        .rootBPM,
//        .synths,
//        .kicks,
//        .snares,
//    ]
    
}
