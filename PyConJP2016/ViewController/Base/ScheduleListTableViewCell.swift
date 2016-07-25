//
//  ScheduleListTableViewCell.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var speakerLabel: UILabel!
    
    func fillWith(talkObject: TalkObject) {
        titleLabel.text = talkObject.title
        timeLabel.text = talkObject.periodTime
        placeLabel.text = talkObject.place
        speakerLabel.text = talkObject.speakers
    }
    
    private func fillRoomColorWith(id: Int) {
        switch id {
        case 201:
            placeView.backgroundColor = .redColor()
        default:
            placeView.backgroundColor = .grayColor()
        }
    }
    
    override func prepareForReuse() {
//        titleLabel.text = nil
//        timeLabel.text = nil
//        roomLabel.text = nil
//        speakerLabel.text = nil
//        self.fillRoomColorWith(0)
    }
    
}
