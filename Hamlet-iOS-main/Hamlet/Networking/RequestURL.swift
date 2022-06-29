//
//  DataObject.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import Alamofire

let devURL = "http://hamletforall.com/api"
//let prodURL = "http://54.215.47.71/api"
let newsLetterURL = "http://hamletforall.com"
let profileImageUploadURL = "http://hamletforall.com/api/profiles/picture"



let baseURL = devURL

enum RequestURL {
    case register
    case login
    case verifyEmail
    case ListCommunity(page : Int)
    case ListPost(page : Int)
    case AllListPost(page : Int)
    case ChatList(page : Int)
    case ChatMessageGet(page : Int, id : String)
    case PostChatMessage(id : String)
    case SelectProblemList
    case SelectProblem
    case TrainerCommunityList(search : String, id : Int)
    case EmailVerify
    case Profile
    case CommunityJoin(id : Int)
    case CommunityLeave(id : Int)
    case PostLike
    case ListOfComment(page : Int)
    case PostInComment
    case sendFriendRequest
    case AllUserList(page :Int)
    case AllFriendsList(page :Int)
    case FriendsRequestList
    case UserViewDetails(id : Int)
    case FriendRequestAcceptReject(id : Int)
    case TrainerBooking
    case ExpertisesList
    case SelectExpertises
    case Meeting
    case CreateGroup
    case Rating
    case GroupChatAcceptReject(id : Int)
    case NotificationList
    case AboutUs
    case ContactUs
    case Privacy
    case CountryList
    case LanguageList
    case TranslateMessage(message_id : Int, target_lang_id : Int)
    case DeleteMessage(message_id : Int)
    case GroupChatUserList(group_id : Int)
    case UserRemoveFromGroup(groupID : Int, userID : Int)
    case ForgotPassword
    case postInCommunity
    case ProfileEdit(id : Int)
    case AllCommunitieList(page :Int)
    case Communitie
    case CommunityAddUser(communityID :Int)
    case UpdateCommunity(communityID :Int)
    case RemoveUserFromCommunity(communityID :Int, UserID: Int)
    case FetchSelectedExpertise(userID: Int)
    case FetchSelectedProblem(userID: Int)
    case PostTranslate(postID:Int, languageID: Int)
    case CommunityUserList(community_id : Int)


    var url: URL? {
        switch self {
        case .register:
            let urlString = "\(baseURL)/register"
            return urlString.getURL()
        case .login:
            let urlString = "\(baseURL)/login"
            return urlString.getURL()
        case .verifyEmail:
            let urlString = "\(baseURL)/verify"
            return urlString.getURL()
        case let .ListCommunity(page):
            let urlString = "\(baseURL)/me/communities?page=\(page)"
            return urlString.getURL()
        case let .ChatList(page):
            let urlString = "\(baseURL)/chats?page=\(page)"
            return urlString.getURL()
        case let .ChatMessageGet(page,id):
            let urlString = "\(baseURL)/chats/\(id)/messages?page=\(page)"
            return urlString.getURL()
        case .SelectProblemList:
            let urlString = "\(baseURL)/problems"
            return urlString.getURL()
        case .SelectProblem:
            let urlString = "\(baseURL)/users/problems"
            return urlString.getURL()
        case let .ListPost(page):
            let urlString = "\(baseURL)/posts?page=\(page)"
            return urlString.getURL()
        case let .AllListPost(page):
            let urlString = "\(baseURL)/posts?page=\(page)"
            return urlString.getURL()
        case let .TrainerCommunityList(search,id):
            let urlString = "\(baseURL)/trainers-and-communities?search=\(search)&problem_id=\(id)&with_expertise=1"
            return urlString.getURL()
        case .EmailVerify:
            let urlString = "\(baseURL)/email/verify"
            return urlString.getURL()
        case .Profile:
            let urlString = "\(baseURL)/me"
            return urlString.getURL()
        case let .CommunityJoin(id):
            let urlString = "\(baseURL)/communities/\(id)/join"
            return urlString.getURL()
        case let .CommunityLeave(id):
            let urlString = "\(baseURL)/communities/\(id)/leave"
            return urlString.getURL()
        case .PostLike:
            let urlString = "\(baseURL)/likes"
            return urlString.getURL()
        case let .ListOfComment(page):
            let urlString = "\(baseURL)/comments?page=\(page)"
            return urlString.getURL()
        case .sendFriendRequest:
            let urlString = "\(baseURL)/friends"
            return urlString.getURL()
        case let .AllUserList(page):
            let urlString = "\(baseURL)/users?page=\(page)"
            return urlString.getURL()
        case let .AllFriendsList(page):
            let urlString = "\(baseURL)/friends?page=\(page)"
            return urlString.getURL()
        case .FriendsRequestList:
            let urlString = "\(baseURL)/friends/invitations"
            return urlString.getURL()
        case let .UserViewDetails(id):
            let urlString = "\(baseURL)/users/\(id)"
            return urlString.getURL()
        case let .FriendRequestAcceptReject(id):
            let urlString = "\(baseURL)/friends/\(id)"
            return urlString.getURL()
        case .TrainerBooking:
            let urlString = "\(baseURL)/bookings"
            return urlString.getURL()
        case .ExpertisesList:
            let urlString = "\(baseURL)/expertises"
            return urlString.getURL()
        case .SelectExpertises:
            let urlString = "\(baseURL)/users/expertises"
            return urlString.getURL()
        case .Meeting:
            let urlString = "\(baseURL)/events/meeting"
            return urlString.getURL()
        case .CreateGroup:
            let urlString = "\(baseURL)/chats"
            return urlString.getURL()
        case .Rating:
            let urlString = "\(baseURL)/ratings"
            return urlString.getURL()
        case let .GroupChatAcceptReject(id):
            let urlString = "\(baseURL)/chats/\(id)"
            return urlString.getURL()
        case .NotificationList:
            let urlString = "\(baseURL)/notifications"
            return urlString.getURL()
        case .AboutUs:
            let urlString = "\(newsLetterURL)/about-us"
            return urlString.getURL()
        case .ContactUs:
            let urlString = "\(newsLetterURL)/contact-us"
            return urlString.getURL()
        case .Privacy:
            let urlString = "\(newsLetterURL)/privacy"
            return urlString.getURL()
        case .CountryList:
            let urlString = "\(baseURL)/countries"
            return urlString.getURL()
        case .LanguageList:
            let urlString = "\(baseURL)/languages"
            return urlString.getURL()
        case let .TranslateMessage(chatMessageID, translateLanguageID):
            let urlString = "\(baseURL)/chats-messages/\(chatMessageID)/\(translateLanguageID)"
            return urlString.getURL()
        case let .DeleteMessage(message_id):
            let urlString = "\(baseURL)/chats-messages/\(message_id)"
            return urlString.getURL()
        case let .GroupChatUserList(group_id):
            let urlString = "\(baseURL)/chats/\(group_id)/participants"
            return urlString.getURL()
        case let .UserRemoveFromGroup(groupID, userID):
            let urlString = "\(baseURL)/chats/\(groupID)/users/\(userID)/kick"
            return urlString.getURL()
        case .ForgotPassword:
            let urlString = "\(baseURL)/password"
            return urlString.getURL()
        case .postInCommunity:
            let urlString = "\(baseURL)/posts"
            return urlString.getURL()
        case .PostInComment:
            let urlString = "\(baseURL)/comments"
            return urlString.getURL()
        case let .PostChatMessage(id):
            let urlString = "\(baseURL)/chats/\(id)/messages"
            return urlString.getURL()
        case let .ProfileEdit(id):
            let urlString = "\(baseURL)/users/\(id)"
            return urlString.getURL()
        case let .AllCommunitieList(page):
            let urlString = "\(baseURL)/communities?page=\(page)"
            return urlString.getURL()
        case .Communitie:
            let urlString = "\(baseURL)/communities"
            return urlString.getURL()
        case let .CommunityAddUser(communityID):
            let urlString = "\(baseURL)/communities/\(communityID)/members/add"
            return urlString.getURL()
        case let .UpdateCommunity(communityID):
            let urlString = "\(baseURL)/communities/\(communityID)"
            return urlString.getURL()
        case let .RemoveUserFromCommunity(communityID, userID):
            let urlString = "\(baseURL)/communities/\(communityID)/member/\(userID)/remove"
            return urlString.getURL()
        case let .FetchSelectedExpertise(userID):
            let urlString = "\(baseURL)/users/\(userID)/expertises"
            return urlString.getURL()
        case let .FetchSelectedProblem(userID):
            let urlString = "\(baseURL)/users/\(userID)/problems"
            return urlString.getURL()
        case let .PostTranslate(postID, languageID):
            let urlString = "\(baseURL)/posts/\(postID)/\(languageID)"
            return urlString.getURL()
        case let .CommunityUserList(community_id):
            let urlString = "\(baseURL)/communities/\(community_id)/participants"
            return urlString.getURL()
        }
    }
}
enum RequestType {
    case get
    case post
    case put
    case delete
}

//http://54.215.47.71/api/password
