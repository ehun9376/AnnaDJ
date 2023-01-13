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
    
//    var data: ProductID = .heart
    
    init(text: String? = nil, number: Int? = nil, data: ProductID) {
        self.text = text
        self.number = number
//        self.data = data
    }
    
    
//    static let heart: CodeModel = .init(text: ProductID.heart.text, number: 0, data: .woodFish)
//    
//    static let drum: CodeModel = .init(text: ProductID.drum.text, number: 1, data: .drum)
//    
//    static let ring: CodeModel = .init(text: ProductID.ring.text, number: 2, data: .ring)
//    
//    static let inSin: CodeModel = .init(text: ProductID.inSin.text, number: 3, data: .inSin)
//    
//    static let gong: CodeModel = .init(text: ProductID.gong.text, number: 4, data: .gong)
//    
//    static let board: CodeModel = .init(text: ProductID.board.text, number: 5, data: .board)
//    
//    static let clock: CodeModel = .init(text: ProductID.clock.text, number: 6, data: .clock)
//    
//    static let dotRing: CodeModel = .init(text: ProductID.dotRing.text, number: 7, data: .dotRing)
//    
//    static let traingle: CodeModel = .init(text: ProductID.traingle.text, number: 8, data: .traingle)
//    
//
//    static let items: [CodeModel] = [
//        .woodFish,
//        .drum,
//        .ring,
//        .inSin,
//        .gong,
//        .board,
//        .clock,
//        .dotRing,
//        .traingle
//    ]
    
}
