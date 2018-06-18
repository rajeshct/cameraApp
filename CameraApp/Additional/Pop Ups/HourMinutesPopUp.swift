//
//  HourMinutesPopUp.swift
//  CameraApp
//
//  Created by Jeevan chandra on 03/05/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class HoursMinutePopUp: CustomPopUp{

    var popUpType: String?{
        didSet{
            setupHourMinute()
        }
    }
    var hourMinute: [String]?{
        didSet{
            searchHourMinute = hourMinute
        }
    }

    var delegate: PopUpSelectDelegate?
    var searchHourMinute: [String]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    func setupHourMinute(){

        var lastIndex = 0
        if popUpType == "hours"{
            lastIndex = 25
        }else{
            lastIndex = 61
        }

        var hours = [String]()
        for index in 0..<lastIndex{

            hours.append(String(index))

        }

        hourMinute = hours

    }


    func setup(){
        contentTable.delegate = self
        contentTable.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HoursMinutePopUp: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchHourMinute?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.07
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EnhancmentRoomPopUpCell
        if popUpType == "hours"{
            delegate?.onClickCell(value: cell.currencyLabel.text, type: "hours", projectId: nil)
        }else{
            delegate?.onClickCell(value: cell.currencyLabel.text, type: "minutes", projectId: nil)
        }

        handleClose()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EnhancmentRoomPopUpCell", for: indexPath) as! EnhancmentRoomPopUpCell
        cell.currencyLabel.text = searchHourMinute?[indexPath.item]
        return cell
    }


}


extension HoursMinutePopUp: UISearchBarDelegate, UISearchDisplayDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchHourMinute = searchText.isEmpty ? hourMinute : hourMinute?.filter({ (hotel) -> Bool in
            return hotel.range(of: searchText, options: .caseInsensitive) != nil
        })

        contentTable.reloadData()

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


