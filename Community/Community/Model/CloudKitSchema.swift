//
//  CloudKitSchema.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 22/08/23.
//

import CloudKit

class CloudKitSchema {
    let recordName: String
    var recordId: CKRecord.ID?
    private var recordInstance: CKRecord?
    var record: CKRecord {
        if recordInstance == nil {
            if recordId != nil {
                recordInstance = CKRecord(recordType: recordName, recordID: recordId!)
            } else {
                recordInstance = CKRecord(recordType: recordName)
            }
        }
        return recordInstance!
    }
    
    func setRecordValues(_ values: [String: Any]) {
        record.setValuesForKeys(values)
    }
    
    init(recordName: String) {
        self.recordName = recordName
    }
}
