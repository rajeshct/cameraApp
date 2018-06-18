//
//  NetworkWebApis.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 07/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class NetworkWebApisConstant{
    
    static let baseUrl = "http://www.account.intellirisecorp.com"
    
    // Login Controller
    struct LoginController{
        static let loginUrl = "/api/User/Login"
        static let forgotPasswordUrl = "/api/User/ForgotPassword"
        static let singUpUrl = ""
        static let editProfile = "/api/User/UpdateProfile"
        static let getAssignIds = "/api/ProjectManagement/GetEmployeeList"
    }
    
    
    // Project Controller
    struct ProjectControllerApi{
        static let projectUrl = "/api/ProjectManagement/GetProjectListForMobile"
        static let projectTaskUrl = "/api/ProjectManagement/GetTaskByDateRange"
        static let projectCreateUrl = "/api/ProjectManagement/AddNewProject"
        static let updateProject = "/api/ProjectManagement/UpdatesProject"
        static let viewAllProject = "/api/ProjectManagement/SearchProject"
    }
    
    // AddTimeController
    
    struct  AddTimeControllerApi {
        static let addTaskUrl = "/api/ProjectManagement/AddNewTask"
        static let updateTask = "/api/ProjectManagement/UpdateTask"
    }
    
    struct GroupsControllerApi{
        
        static let groupListsUrl = "/api/ProjectManagement/GetProjectList"
        static let groupChatComments = "/api/ProjectManagement/GetGroupComment"
        static let createGroupMessage =  "/api/ProjectManagement/CreateGroupMessage"
        static let deleteConversation = "/api/ProjectManagement/DeleteComment"
        static let getConversationSeen = "/api/ProjectManagement/GetCommentSeen"
        static let setSeenBy = "api/ProjectManagement/SetCommentSeen"
        static let getSeenBy = "/api/ProjectManagement/GetCommentSeen"
        static let updateConversation = "/api/ProjectManagement/UpdateComment"
        static let createSubGroup = "/api/ProjectManagement/CreateSubGroup"
        
    }
    
    
    
    
}
