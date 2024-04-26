# Opacity Tracker Blocking
This is a list of tracker blocking rules used in the Opacity browser.
It was created based on 'categorized_trackers' of '[DuckDuckGo Tracker Radar](https://github.com/duckduckgo/tracker-radar)' provided by '[DuckDuckGo](https://github.com/duckduckgo)'.

## Blocking Level
Domains are classified into three levels based on their category. If a domain falls under multiple categories, it is categorized according to the highest level. Higher levels include all domains from the lower levels.

### Level 1 (Light)
It provides basic tracking protection without significantly disrupting the user experience.  
> Categories blocked.  
> Ad Motivated Tracking, Advertising, Ad Fraud, Analytics, Audience Measurement, Third-Party Analytics Marketing, Action Pixels, Unknown High Risk Behavior, Obscure Ownership, Badge, Session Replay, Malware, Consent Management Platform, Tag Manager, Support Chat Widget

### Level 2 (Moderate)
It provides a reasonable level of protection while still allowing some tracking if necessary.
> Categories blocked.  
> Embedded Content, Social Network, Non-Tracking, Fraud Prevention, Social - Comment, Social - Share, Online Payment

### Level 3 (strong)
Provide maximum protection for user data and interactions.    
> Categories blocked.  
> Federated Login, SSO, CDN

## Licensing
Because the foundational '[DuckDuckGo Tracker Radar](https://github.com/duckduckgo/tracker-radar)' is governed by the '[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/)', the same license is applied to 'Opacity Tracker Blocking'.

## Version
1.0.0