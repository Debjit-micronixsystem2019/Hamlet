//
//  TranslateChatmessageViewModel.swift
//  Hamlet
//
//  Created by admin on 12/3/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
class TranslateChatMessageViewModel {
    var translateChatMessageResponse: TranslateChatMessageResponse? = nil
}

extension TranslateChatMessageViewModel {
    func requestTranslateChatMessage(with message_id : Int, target_lang_id : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = [:]
        
        Webservice().request(url: RequestURL.TranslateMessage( message_id: message_id, target_lang_id: target_lang_id).url, requestType: .get, params: requestParam) { [weak self] (result) in
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
                        self?.translateChatMessageResponse = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
     }
}
