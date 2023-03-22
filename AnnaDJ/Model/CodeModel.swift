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
    }
    
    var text: String?
    
    var number: Int?
    
    var data: SoundModel?
    
    init(text: String? = nil, number: Int? = nil, data: SoundModel? = nil) {
        self.text = text
        self.number = number
        self.data = data
    }
    
    
}
