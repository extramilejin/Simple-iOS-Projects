//
//  EVTableViewController.swift
//  EVMap
//
//  Created by 진형진 on 2021/03/07.
//

import UIKit

class EVTableViewController: UITableViewController, XMLParserDelegate, MTMapViewDelegate {
    var evStations: [EVStation] = []
    var currentEVStation: EVStation?
    var onParsing: Bool = false
    var currentElement = ""
    var elementCount = 0
    let eCarKey = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let strURL = "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=\(eCarKey)&numOfRows=10&pageNo=1"
        self.title = "실시간 전기차 충전소 정보"
        if let url = URL(string: strURL) {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self

                if parser.parse() {
                    print("파싱성공")

                } else {
                    print("파싱실패")
                }
            }
        } else {
            print("URL error")
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            currentElement = elementName
            if elementName == "item" && !onParsing {
                onParsing = true
                currentEVStation = EVStation()
            }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if onParsing {
            let parseString = string.trimmingCharacters(in: .whitespacesAndNewlines)
            switch currentElement {
            case "statNm": currentEVStation!.statNm = parseString
            case "statId": currentEVStation!.statId = parseString
            case "addr": currentEVStation!.addr = parseString
            case "lat": currentEVStation!.lat = Double(parseString)!
            case "lng": currentEVStation!.lng = Double(parseString)!
            default: break
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" && onParsing {
            evStations.append(currentEVStation!)
            onParsing = false
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evStations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "evCell", for: indexPath) as! EVTableViewCell
        cell.EVStatNm.text = evStations[indexPath.row].statNm
        cell.EVStatAddrLabel.text = evStations[indexPath.row].addr
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = evStations[indexPath.row]
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EVStationDetail") as? EVStationDetailViewController else {
            return
        }
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
