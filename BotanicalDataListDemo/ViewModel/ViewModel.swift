//
//  ViewModel.swift
//  BotanicalDataListDemo
//
//  Created by Joshua Chang on 2021/5/10.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import Foundation

final class ViewModel {
    
    var cellViewModel: [CellViewModel]?
    
    func invokeDataList(completionHandler handler: @escaping(() -> ())) {
        BotanicalDataServiceRouter.query(BotanicalDataServiceRouter.getBotanicalData) { [weak self] (result: Result<BotanicalDataList, Error>) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let response):
                guard let results = response.result?.results else { return }
                weakSelf.cellViewModel = []
                for result in results {
                    weakSelf.cellViewModel?.append(CellViewModel(result.fNameCh, result.fLocation, result.fFeature, result.fPic01URL))
                }
                handler()
            case .failure(let err):
                guard let error = err as? BotanicalDataServiceError else { return }
                debugPrint("BotanicalDataServiceError: \(error)")
            }
        }
    }
    
}
