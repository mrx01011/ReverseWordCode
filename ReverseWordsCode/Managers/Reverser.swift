//
//  Reverser.swift
//  ReverseWordsCode
//
//  Created by Vladyslav Nhuien on 04.08.2022.
//

final class Reverser { 
    func defaultReverse(textToReverse text: String) -> String {
        var words = text.components(separatedBy: .whitespaces)
        for (index, word) in words.enumerated() {
            //Only letters
            if word.allSatisfy(\.isLetter) {
                words[index] = String(word.reversed())
                continue
            }
            //No letters
            if !word.contains(where: \.isLetter) { continue }
            //Mix
            var reversed = word.reversed().filter(\.isLetter)
            for (index, char) in word.enumerated() {
                if !char.isLetter {
                    index < reversed.endIndex ? reversed.insert(char, at: index) : reversed.append(char)
                }
            }
            words[index] = String(reversed)
        }
        return words.joined(separator: " ")
    }
    func reverseWithIgnoreRules(textToReverse fullText: String, textToIgnore ignore: String) -> String {
        var set = Set<Character>()
        let squeezed = ignore.filter{ set.insert($0).inserted }
        let fullTextArray = fullText.components(separatedBy: " ")
        var posOfChars: [[String:[Int]]] = [] // posOfChars[i] is a dict [String:[Int]], giving the positions of each excluded chars in component i
        for (i, comp) in fullTextArray.enumerated() {
            posOfChars.append( [:] )
            for c in squeezed {
                for (pos, charInComp) in comp.enumerated() {
                    if charInComp == c {
                        if posOfChars[i][String(c)] == nil {
                            posOfChars[i][String(c)] = [pos]
                        } else {
                            posOfChars[i][String(c)]!.append(pos)//
                        }
                    }
                }
            }
        }
        var newTextArray = fullTextArray
        for (i, _) in fullTextArray.enumerated() {
            for c in squeezed {
                newTextArray[i] = newTextArray[i].replacingOccurrences(of: String(c), with: "")
            }
        }
        newTextArray = newTextArray.map() { String($0.reversed()) }
        for i in 0..<fullTextArray.count { // Get each component
            var orderedArray = [(Int, String)] ()
            for toRestore in posOfChars[i] {
                for item in toRestore.value {
                    orderedArray.append((item, toRestore.key))
                }
                orderedArray = orderedArray.sorted() { $0.0 < $1.0 }
            }
            for (index, str) in orderedArray {
                let posIndex = newTextArray[i].index(newTextArray[i].startIndex, offsetBy: index)
                let char = str[0]
                newTextArray[i].insert(char, at: posIndex)
            }
        }
        return newTextArray.joined(separator: " ")
    }
}
