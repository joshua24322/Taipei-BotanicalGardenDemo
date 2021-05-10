//
//  MockViewModel.swift
//  BotanicalDataListDemoTests
//
//  Created by Joshua Chang on 2021/5/10.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import Foundation

final class MockViewModel {
    func invokeDataList(completionHandler handler: @escaping((Bool) -> ())) {
        BotanicalDataServiceRouter.query(BotanicalDataServiceRouter.getBotanicalData) { (result: Result<BotanicalDataList, Error>) in
            switch result {
            case .success(let response):
                handler(response.result != nil ? true : false)
            case .failure(let err):
                guard let error = err as? BotanicalDataServiceError else { return }
                debugPrint("BotanicalDataServiceError: \(error)")
                handler(false)
            }
        }
    }
}
