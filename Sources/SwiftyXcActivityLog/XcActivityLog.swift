//
//  XcActivityLog.swift
//  SwiftyXcActivityLog
//
//  Created by Kotaro Suto on 2021/04/10.
//

import Foundation
import Files
import Gzip

public class XcActivityLog {
    var productName: String
    public init(productName: String) {
        self.productName = productName
    }
    
    private func getProductFolder(by productName: String, in root: String = (try? Folder.library?.subfolder(at: "Developer/Xcode/DerivedData").path) ?? "") -> Folder? {
        do {
            let folders = try Folder(path: root).subfolders
            let filteredFolders = folders.filter { (folder) -> Bool in
                return folder.name.contains(productName)
            }
            if filteredFolders.count == 0 {
                return nil
            } else if filteredFolders.count >= 1 {
                // Always return the first element
                // Change if needed
                return filteredFolders.first!
            }
        } catch {
            print("The location couldn’t be found.")
        }
        
        return nil
    }
    
    private func getXcActivityLog(by productName: String) -> [File]? {
        guard let productFolder = getProductFolder(by: productName) else { print("productFolder not found"); return nil }
        do {
            let files = try productFolder.subfolder(at: "Logs/Build").files
            let filteredFiles = files.filter { file -> Bool in
                return file.name.contains(".xcactivitylog")
            }
            
            if filteredFiles.count == 0 {
                return nil
            } else {
                return filteredFiles
            }
        } catch {
            print("The location couldn’t be found.")
        }
        
        return nil
    }
    
    public func asRaw() -> Data? {
        guard let files = getXcActivityLog(by: productName) else {
            print("getDerivedData failed")
            return nil
        }
        do {
            let optionalFile = files.max { (lhs, rhs) -> Bool in
                guard let lDate = lhs.modificationDate, let rDate = rhs.modificationDate else { return false }
                return lDate < rDate
            }
            guard let file = optionalFile else { return nil }
            let data = try file.read()
            return data
        } catch {
            print("reading the file failed")
        }
        return nil
    }
    
    public func asUnzipped() -> Data? {
        guard let raw = asRaw() else { return nil }
        do {
            let unzipped = try raw.gunzipped()
            return unzipped
        } catch {
            print("Unzipping Failed")
        }
        
        return nil
    }
    
    public func asStringArray() -> [String]? {
        guard let unzipped = asUnzipped(), let str = String(data: unzipped, encoding: .utf8) else { return nil }
        return str.split(separator: "\r").map { String($0) }
    }
    
    public func asExecutions() -> [Execution]? {
        guard let array = asStringArray() else { return nil }
        return array.map { line in
            guard line.isReadableByPattern() else { return nil }
            let components = line.split(separator: "\t", maxSplits: 3)
            var timeString = String(components[0])
            timeString = String(timeString[timeString.startIndex ..< (timeString.firstIndex(of: "m") ?? timeString.endIndex)])
            guard !String(components[1]).contains("invalid loc") else {
                return Execution(time: TimeInterval(timeString)!, file: nil, methodName: String(components[2]), line: 0, column: 0)
            }
            let sep = String(components[1]).split(separator: ":")
            let filePath = String(sep[0])
            let lineNum = Int(sep[1]) ?? 0
            let lineCol = Int(sep[2]) ?? 0
            let fileOfCode = try! File(path: filePath)
            return Execution(time: TimeInterval(timeString)!, file: fileOfCode, methodName: String(components[2]), line: lineNum, column: lineCol)
        }
        .compactMap { $0 }
    }
}

