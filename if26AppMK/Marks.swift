//
//  Marks.swift
//  if26AppMK
//
//  Created by if26-grp3 on 20/12/2017.
//  Copyright © 2017 if26-grp3. All rights reserved.
//

import Foundation

class Markss {
    
    var id: Int
    var subjectCode: String?
    var subjectMark: String
    
    init(id: Int, subjectCode: String?, subjectMark: String){
        self.id = id
        self.subjectCode = subjectCode
        self.subjectMark = subjectMark
    }
    
}
