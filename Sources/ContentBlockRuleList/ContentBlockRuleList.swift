import Foundation
import WebKit
import TrackerRadarKit

public struct ContentBlockRuleList {
  
  let webView: WKWebView
  
  public init(webView: WKWebView) {
    self.webView = webView
  }
  
  public func updateRules(isBlocking: Bool) {
    if isBlocking {
      addContentBlockingRules()
      addOtherBlockingRules()
    } else {
      self.webView.configuration.userContentController.removeAllContentRuleLists()
    }
  }
  
//  private func addOtherContentBlockingRules() {
//    WKContentRuleListStore.default().lookUpContentRuleList(forIdentifier: "OtherContentBlockRules") { result, error in
//      if let result = result {
//        self.webView.configuration.userContentController.add(result)
//        print("Add other tracker blocking - cache")
//      } else {
//        print("result = nil OtherContentBlockRules lookUpContentRuleList")
//        self.addOtherBlockingRules()
//      }
//    }
//  }
  
  private func addOtherBlockingRules() {
    if let rulePath = Bundle.module.path(forResource: "blockingRules", ofType: "json"),
       let ruleString = try? String(contentsOfFile: rulePath) {
      WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "OtherContentBlockRules", encodedContentRuleList: ruleString) { result, error in
        if let result = result {
          self.webView.configuration.userContentController.add(result)
          print("Add other tracker blocking")
        }
      }
    }
  }
  
  private func addContentBlockingRules() {
    WKContentRuleListStore.default().lookUpContentRuleList(forIdentifier: "ContentBlockRules") { result, error in
      if let result = result {
        self.webView.configuration.userContentController.add(result)
        print("Add tracker blocking - cache")
      } else {
        print("result = nil ContentBlockRules lookUpContentRuleList")
        self.addBlockingRules()
      }
    }
  }
  
  private func addBlockingRules() {
    if let rulePath = Bundle.module.path(forResource: "duckduckgoTrackerBlocklists", ofType: "json") {
      do {
        let ruleData = try Data(contentsOf: URL(fileURLWithPath: rulePath))
        let tds = try JSONDecoder().decode(TrackerData.self, from: ruleData)
        let builder = ContentBlockerRulesBuilder(trackerData: tds)
        let rules = builder.buildRules(withExceptions: [], andTemporaryUnprotectedDomains: [], andTrackerAllowlist: [])
        let data = try JSONEncoder().encode(rules)
        let ruleList = String(data: data, encoding: .utf8)!
        
        WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "ContentBlockRules", encodedContentRuleList: ruleList) { result, error in
          if let result = result {
            self.webView.configuration.userContentController.add(result)
            print("Add tracker blocking")
          }
        }
      } catch {
        print("Error loading or decoding tracker data: \(error)")
      }
    }
  }
}
