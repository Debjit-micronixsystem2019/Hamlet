//
//  RequestChatDeleteMessage.swift
//  Hamlet
//
//  Created by admin on 12/3/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import Foundation
class ChatDeleteMessageViewModel {
    var chatDeleteMessageResponse: TranslateChatMessageResponse? = nil
}

extension ChatDeleteMessageViewModel {
    func requestChatDeleteMessage(with message_id : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = [:]
        
        Webservice().request(url: RequestURL.DeleteMessage( message_id: message_id).url, requestType: .delete, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(TranslateChatMessageResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.chatDeleteMessageResponse = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
     }
}
