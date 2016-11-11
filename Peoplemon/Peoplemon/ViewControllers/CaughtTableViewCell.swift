//
//  CaughtTableViewCell.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/11/16.
//  Copyright © 2016 Interapt. All rights reserved.
//
import UIKit

class CaughtTableViewCell: UITableViewCell {

    weak var caught: People!

    @IBOutlet weak var caughtLabel: UILabel!



    var people: People!

    func setUpCell(people: People){
        self.people = people
        caughtLabel.text = people.userName

    }

}

