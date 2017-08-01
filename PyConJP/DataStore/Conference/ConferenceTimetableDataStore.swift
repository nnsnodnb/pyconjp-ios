//
//  ConferenceTimetableDataStore.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/18.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import UIKit

final class ConferenceTimetableDataStore {
    
    private(set) var timetable: Timetable
    let pyconJPDate: PyConJPDate
    
    private let loadTalksRequest: LoadTalksRequest
    private let apiRequest: TalksAPIRequest = TalksAPIRequest()
    
    init?(pyconJPDate: PyConJPDate) {
        self.pyconJPDate = pyconJPDate
        self.loadTalksRequest = LoadTalksRequest(day: pyconJPDate.description)
        do {
            self.timetable = Timetable(talks: try loadTalksRequest.load())
        } catch {
            return nil
        }
    }
    
    func room(_ indexPath: IndexPath) -> Room {
        return timetable.rooms[indexPath.column - Section.frozenColumns]
    }
    
    func hourClock(_ indexPath: IndexPath) -> String {
        return timetable.start?.calculate(minute: indexPath.row)?.hourClock ?? ""
    }
    
    func talk(_ indexPath: IndexPath) -> TalkObject? {
        guard let date = timetable.start?.calculate(minute: indexPath.row) else { return nil }
        return timetable.tracks[indexPath.column - Section.frozenColumns].talks.filter({ talkObject in
            return talkObject.startDate < date && date < talkObject.endDate
        }).first
    }
    
    func numberOfColumns() -> Int {
        return Section.numberOfColumns(timetable.rooms.count)
    }
    
    func numberOfRows() -> Int {
        return Section.numberOfRows(timetable.minutesDuration)
    }
    
    func cellIdentifier(_ indexPath: IndexPath) -> String? {
        return Section(indexPath: indexPath).cellIdentifier
    }
    
    func widthForColumn(_ column: Int) -> CGFloat {
        return Section(indexPath: IndexPath(row: 0, column: column)).widthForColumn
    }
    
    func heightForRow(_ row: Int) -> CGFloat {
        return Section(indexPath: IndexPath(row: row, column: 0)).heightForRow
    }
    
    func frozenColumns() -> Int {
        return Section.frozenColumns
    }
    
    func frozenRows() -> Int {
        return Section.frozenRows
    }
    
    enum Section {
        case corner
        case rowHeader
        case columnHeader
        case timetable
        
        init(indexPath: IndexPath) {
            switch (indexPath.row, indexPath.column) {
            case (0, 0):
                self = .corner
            case (0, _):
                self = .rowHeader
            case (_, 0):
                self = .columnHeader
            default:
                self = .timetable
            }
        }
        
        var cellIdentifier: String? {
            switch self {
            case .corner:
                return nil
            case .rowHeader:
                return TimetableRoomCell.nibName
            case .columnHeader:
                return TimetableTimeAxisCell.nibName
            case .timetable:
                return TimetableCell.nibName
            }
        }
        
        var widthForColumn: CGFloat {
            switch self {
            case .corner:
                return TimetableTimeAxisCell.width
            case .rowHeader:
                return TimetableRoomCell.width
            case .columnHeader:
                return TimetableTimeAxisCell.width
            case .timetable:
                return TimetableCell.width
            }
        }
        
        var heightForRow: CGFloat {
            switch self {
            case .corner:
                return TimetableRoomCell.height
            case .rowHeader:
                return TimetableRoomCell.height
            case .columnHeader:
                return TimetableTimeAxisCell.height
            case .timetable:
                return TimetableCell.height
            }
        }
        
        static var frozenColumns: Int {
            return 1
        }
        
        static var frozenRows: Int {
            return 1
        }
        
        static func numberOfColumns(_ count: Int) -> Int {
            return count + frozenColumns
        }
        
        static func numberOfRows(_ length: Int) -> Int {
            return length + frozenRows
        }
    }
    
}
