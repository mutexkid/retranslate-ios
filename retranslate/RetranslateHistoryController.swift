
import UIKit

class RetranslateHistoryController: UITableViewController {

    var retranslateDataStore:RetranslateDataStore
    var translation:Translation?
    var translationSteps:[TranslationStep]?
    let resultsViewController:ResultsViewController
    
    init(retranslateDataStore: RetranslateDataStore,
        resultsViewController: ResultsViewController){
        self.retranslateDataStore = retranslateDataStore
        self.translation = retranslateDataStore.lastTranslation
        self.translationSteps = translation?.translationSteps ?? [TranslationStep]()
        self.resultsViewController = resultsViewController
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ItemCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        self.translation = retranslateDataStore.lastTranslation
        tableView.reloadData()
        println(translation?)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translation?.translationSteps.count ?? 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let step = translationSteps?[indexPath.item]
        if let x = step? {
            let phrase = x.getEnglishPhrase()
            resultsViewController.pendingReload = true
            resultsViewController.startRetranslation(phrase)
            navigationController?.popToViewController(resultsViewController, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as ItemCell
        var step = self.translationSteps?[indexPath.item]
        cell.startingPhrase.text = step?.startingPhrase ?? ""
        cell.endingPhrase.text = step?.endingPhrase ?? ""
        let fromLanguage = step?.fromLanguage
        let toLanguage = step?.toLanguage
        
        cell.fromLanguage.text = "\(fromLanguage!) to \(toLanguage!)"
        return cell
    }
    
}