//
//  ViewController.swift
//  Audify
//
//  Created by manikandan bangaru on 17/07/21.
//

import UIKit
import MobileCoreServices
import MediaPlayer
import MusicKit
@objc extension AVMetadataItem{
    //KVC
    func setString(value : String){
        //Key value coding
        let metaKeyPath = #keyPath(AVMetadataItem.stringValue)
        self.setValuesForKeys([metaKeyPath : value])
    }
    func setCommonKey(key : AVMetadataKey){
        let metaKeyPath = #keyPath(AVMetadataItem.commonKey)
        self.setValuesForKeys([metaKeyPath : key])
    }
}
class ViewController: UIViewController, UIDocumentMenuDelegate, UIDocumentPickerDelegate {
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        print("option  selected \( documentPicker.title)")
       
        
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
      
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard urls.count > 0 else{
            print("No Document selecteed")
            return
        }
//        print("Document selected \(urls)")
        
        if let musicFile_URL = urls.first
        {
            print("Content of Meta Info for Song")
            
            let asset = AVAsset(url: musicFile_URL)
            let metaInfo = asset.commonMetadata
//            let formatsKey = "availableMetadataFormats"

//            asset.loadValuesAsynchronously(forKeys: [formatsKey]) {
//                var error: NSError? = nil
//                let status = asset.statusOfValue(forKey: formatsKey, error: &error)
//                if status == .loaded {
//                    for format in asset.availableMetadataFormats {
//                        let metadata = asset.metadata(forFormat: format)
//                        // process format-specific metadata collection
//                    }
//                }
//            }
            for meta in metaInfo{
                if meta.commonKey == AVMetadataKey.commonKeyTitle{
                    //Song Title
                    meta.setString(value: "New Song Title")
                }
                else  if meta.commonKey == AVMetadataKey.commonKeyArtist{
                    //Artist
                    meta.setString(value: "Artist name")
                }
                else  if meta.commonKey == AVMetadataKey.commonKeyAuthor{
                    //Author
                    meta.setString(value: "Author")
                }
                else  if meta.commonKey == AVMetadataKey.commonKeyCreator{
                    //Creator
                    meta.setString(value: "Creator")
                }
            }
            
        }
        
    }
     

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func importFile(_ sender: Any) {
        let doc_types = [String(kUTTypeAudio) , String(kUTTypeMP3) ]
        let documentBrowser = UIDocumentMenuViewController(documentTypes: doc_types, in: .import)
        documentBrowser.delegate = self
        self.present(documentBrowser, animated: true, completion: nil)
        
        //        let doc_URL = String(kUTTypeAudio)
        //        print(doc_URL)
        //        let doc_Picker = UIDocumentPickerViewController()
        //        let url = URL(string : FileManager.default.temporaryDirectory.absoluteString)!
        //        let a = UIDocumentPickerViewController(forExporting: [url], asCopy: true)

        
    }
   
}

