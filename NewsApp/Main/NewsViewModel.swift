//
//  ArticlesViewModel.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 13/7/22.
//

import Foundation
import Network

protocol IArticlesViewModel {
    var data: [DBArticle] { get }
    func monitorNetwork()
    func getAllData( completion: @escaping (Result<[DBArticle], Error> ) -> ())
}

class ArticlesViewModel: IArticlesViewModel {

    var data: [DBArticle] = []
    let monitor = NWPathMonitor()
    private var isNetworkAvailable: Bool = false
    
    func getAllData(completion: @escaping (Result<[DBArticle], Error>) -> ()) {
        if (isNetworkAvailable) {
        NetworkService.shared.sendRequest(
            router: ArticlesRouter.getAll,
            successModel: NewsResponse.self
        ) { response in
                switch response {
                case .success(let model):
                    model.articles?.forEach({ article in
                        let dbarticle = DBArticle(article)
                        self.data.append(dbarticle)
                        DBManager.shared.addData(object: dbarticle)
                    })
                    completion(.success(self.data))
                    
                case .failure(let error):
                    self.data = DBManager.shared.getDataFromDB()
                    if (self.data.count != 0) {
                        completion(.success(self.data))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
        } else {
            self.data = DBManager.shared.getDataFromDB()
            completion(.success(self.data))
        }
        stopMonitoring()
    }
    
    func monitorNetwork() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isNetworkAvailable = true
            } else {
                self?.isNetworkAvailable = false
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }

}
