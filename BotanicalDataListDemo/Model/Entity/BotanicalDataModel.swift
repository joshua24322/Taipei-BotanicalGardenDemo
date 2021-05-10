//
//  BotanicalDataModel.swift
//  BotanicalDataListDemo
//
//  Created by Joshua Chang on 2021/5/9.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import Foundation

// MARK: - BotanicalDataList
struct BotanicalDataList: Codable {
    let result: BotanicalDataListResult?
}

// MARK: - BotanicalDataListResult
struct BotanicalDataListResult: Codable {
    let limit: Int?
    let offset: Int?
    let count: Int?
    let sort: String?
    let results: [ResultElement]?
}

// MARK: - ResultElement
struct ResultElement: Codable {
    let fNameCh, fLocation, fFeature, fPic01URL: String?

    enum CodingKeys: String, CodingKey {
        case fNameCh = "F_Name_Ch"
        case fLocation = "F_Location"
        case fFeature = "F_Feature"
        case fPic01URL = "F_Pic01_URL"
    }
}


