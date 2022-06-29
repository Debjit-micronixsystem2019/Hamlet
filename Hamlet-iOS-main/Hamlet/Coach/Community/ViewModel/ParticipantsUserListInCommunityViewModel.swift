//
//  ParticipantsUserCommunityViewModel.swift
//  Hamlet
//
//  Created by admin on 6/28/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

class ParticipantsUserListInCommunityViewModel {
    var participantUserInCommunity: [ParticipantUserInCommunityDataModel]? = nil
}

extension ParticipantsUserListInCommunityViewModel {
    func requestForParticipantUserListInCommunity(communityID : Int,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [:]
        
        Webservice().request(url: RequestURL.CommunityUserList(community_id: communityID).url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(ParticipantUserInCommunityResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.participantUserInCommunity = result
                        completion(.success)
                    } else {
                        completion(.failure(HTError.noData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
