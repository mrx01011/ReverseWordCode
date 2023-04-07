//
//  StringProtocol.swift
//  ReverseWordsCode
//
//  Created by Vladyslav Nhuien on 04.08.2022.
//

extension StringProtocol { //file
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
