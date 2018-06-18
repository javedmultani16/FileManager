//
//  ViewController.swift
//  NSFileManager
//
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button actions
   
    @IBAction func buttonHandlerCreateDirectory(_ sender: Any) {
        //create directory
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let logsPath = documentsPath.appendingPathComponent("data")
        print(logsPath!)
        
        do{
            try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
            
        }catch let error as NSError{
            print("Unable to create directory",error)
        }
        
        
    }
    
    @IBAction func buttonHandlerWriteFile(_ sender: Any) {
        let file = "file1.txt"
        let text = "some text"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(file)
            //writing
            
            do{
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }catch{
                print("cant write...")
            }
        }
        
    }
    
    @IBAction func buttonHandlerReadFile(_ sender: Any) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let file = "file1.txt"
            let fileURL = dir.appendingPathComponent(file)
            
            //reading
            
            do{
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                print(text)
            }catch{
                print("cant read...")
            }
        }
    }
    
    @IBAction func buttonHandlerMoveFile(_ sender: Any) {
        //Move File
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let oldPath = dir.appendingPathComponent("fileMove.txt")
            let newPath = dir.appendingPathComponent("data/fileMove.txt")
            let fileManager = FileManager.default
            do{
                try fileManager.moveItem(at: oldPath, to: newPath)
            }catch{
                print("cant move the file...")
            }
        }
        
        
    }
    
    @IBAction func buttonHandlerCopyFile(_ sender: Any) {
        //copy file
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let originalFile = dir.appendingPathComponent("file1.txt")
            let copyFile = dir.appendingPathComponent("copy.txt")
            
            let fileManager = FileManager.default
            do{
                try fileManager.copyItem(at: originalFile, to: copyFile)
            }catch{
                print("can't copy")
            }
        }
    }
    
    @IBAction func buttonHandlerFilePermission(_ sender: Any) {
        //File permissions
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("file1.txt"){
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            
            if fileManager.fileExists(atPath: filePath){
                print("File Available")
            }else{
                print("File not available")
            }
            
            var filePermission:NSString = ""
            if (fileManager.isWritableFile(atPath: filePath)){
                filePermission = filePermission.appending("file is writable") as NSString
            }
            if(fileManager.isReadableFile(atPath: filePath)){
                filePermission = filePermission.appending("file is readable") as NSString
            }
            if(fileManager.isExecutableFile(atPath: filePath)){
                filePermission = filePermission.appending("file is executable") as NSString
            }
            
            print(filePermission)
            
            
        }
        
        
    }
    
    @IBAction func buttonHandlerCheck(_ sender: Any) {
        //check file contents are same or not
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let fileManager = FileManager.default
        if let pathComponent1 = url.appendingPathComponent("file1.txt"){
            if let pathComponent2 = url.appendingPathComponent("file2.txt"){
                let filePath1 = pathComponent1.path
                let filePath2 = pathComponent2.path
                print(try! fileManager.contentsEqual(atPath: filePath1, andPath: filePath2))
                
            }
        }
        
        
    }
    
    @IBAction func buttonHandlerRemoveFile(_ sender: Any) {
        //remove file
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let removeFile = dir.appendingPathComponent("copy.txt")
            let fileManager = FileManager.default
            do{
                try fileManager.removeItem(at: removeFile)
            }catch{
                print("cant remove file...")
            }
        }
    }
    
    @IBAction func buttonHandlerListing(_ sender: Any) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.path
        let fileManager = FileManager.default
        print(try! fileManager.contentsOfDirectory(atPath: filePath!))
    }
    
}

