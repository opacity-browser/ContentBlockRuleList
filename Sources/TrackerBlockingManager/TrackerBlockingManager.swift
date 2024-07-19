import WebKit
import TrackerRadarKit
import Foundation

public class ContentBlockingManager {
  public init() {}
  
  public func updateBlockingRules(_ webView: WKWebView, isTrackerBlocking: Bool) {
    if isTrackerBlocking {
      getCacheContentBlockingRules(webView)
      getCacheOtherContentBlockingRules(webView)
    } else {
      webView.configuration.userContentController.removeAllContentRuleLists()
    }
  }
  
  private func getCacheOtherContentBlockingRules(_ webView: WKWebView) {
    WKContentRuleListStore.default().lookUpContentRuleList(forIdentifier: "OtherContentBlockingRules") { result, error in
      if let error = error {
        print("Error OtherContentBlockingRules lookUpContentRuleList : \(error)")
        return
      }
      
      if let result = result {
        webView.configuration.userContentController.add(result)
        print("Add other tracker blocking - cache")
      } else {
        self.addOtherBlockingRules(webView)
      }
    }
  }
  
  private func addOtherBlockingRules(_ webView: WKWebView) {
    if let rulePath = Bundle.main.path(forResource: "blockingRules", ofType: "json"),
       let ruleString = try? String(contentsOfFile: rulePath) {
      WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "OtherContentBlockingRules", encodedContentRuleList: ruleString) { result, error in
        if let error = error {
          print("Error compiling other content rule list: \(error)")
          return
        }
        
        if let result = result {
          webView.configuration.userContentController.add(result)
          print("Add other tracker blocking")
        }
      }
    }
  }
  
  private func getCacheContentBlockingRules(_ webView: WKWebView) {
    WKContentRuleListStore.default().lookUpContentRuleList(forIdentifier: "ContentBlockingRules") { result, error in
      if let error = error {
        print("Error ContentBlockingRules lookUpContentRuleList : \(error)")
        return
      }
      
      if let result = result {
        webView.configuration.userContentController.add(result)
        print("Add tracker blocking - cache")
      } else {
        self.addContentBlockingRules(webView)
      }
    }
  }
  
  private func addContentBlockingRules(_ webView: WKWebView) {
    if let rulePath = Bundle.main.path(forResource: "duckduckgoTrackerBlocklists", ofType: "json") {
      do {
        let ruleData = try Data(contentsOf: URL(fileURLWithPath: rulePath))
        let tds = try JSONDecoder().decode(TrackerData.self, from: ruleData)
        let builder = ContentBlockerRulesBuilder(trackerData: tds)
        let rules = builder.buildRules(withExceptions: [], andTemporaryUnprotectedDomains: [], andTrackerAllowlist: [])
        let data = try JSONEncoder().encode(rules)
        let ruleList = String(data: data, encoding: .utf8)!
        
        WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "ContentBlockingRules", encodedContentRuleList: ruleList) { result, error in
          if let error = error {
            print("Error compiling content rule list: \(error)")
            return
          }
          
          if let result = result {
            webView.configuration.userContentController.add(result)
            print("Add tracker blocking")
          }
        }
      } catch {
        print("Error loading or decoding tracker data: \(error)")
      }
    }
  }
}
