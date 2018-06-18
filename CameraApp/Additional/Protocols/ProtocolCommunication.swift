//
//  ProtocolCommunication.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import Foundation


    //  Add time controller protocol communication
protocol PopUpSelectDelegate {
    func onClickCell(value: String?, type: String, projectId: Int?)
}


    // On Succesfull Login
protocol PresentCameraDelegate{
    func presentCamera()
}

    //Calendar dates
protocol CalendarDatesDelegate {
    func setCalendarDates(startDate: Date?, endDate: Date?)
}


//  Add time controller protocol communication
protocol ProjectAssignDelegate {
    func onClickCell(value: String?, assignId: String?)
}

/// On edit or create task
protocol RefreshProjectsDelegate{
    func onRefreshProjects()
    func onRefreshTask()
}

// On date selection
protocol OnTaskDateSelection {
    func dateTaskCellClicked(projectData: [ProjectTaskModel]?)
    func onPreviousNextButtonClicked(startingDating: String, endingDate: String)
}


// View full coversation

protocol ViewFullConversationDelegate{
    func handleFullConversation(item: Int)
    func handleSeenBy(commentId: Int?)
    func handleDeleteConversation(item: Int?)
    func handleEdit(item: Int?)
}


// Delete conversation

protocol DeleteConversationDelegate{
    
    func deleteConversation()
}
