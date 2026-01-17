# Holberton School Domain Reconnaissance Report

## 1. General Information
* **Target Domain:** holbertonschool.com
* **Reconnaissance Tools:** Subfinder, Dig, Public Passive DNS
* **Date:** 2026-01-17

## 2. IP Addresses and Network Infrastructure
Analysis of the subdomain enumeration reveals a heavy reliance on cloud infrastructure. The domain does not host its own physical data centers but utilizes major cloud providers.

### Identified IP Providers

| Provider | Observed IPs | Associated Subdomains |
| :--- | :--- | :--- |
| **Amazon Web Services (AWS)** | `99.83.190.102`<br>`75.2.70.75`<br>`34.203.198.145`<br>`54.157.56.129`<br>`52.85.96.82`<br>`63.35.51.142` | `holbertonschool.com` (Root)<br>`help` (Zendesk via AWS)<br>`v2`, `v3` (Intranet versions)<br>`alpha`<br>`rails-assets` |
| **Cloudflare** | `104.16.53.111` | `support`<br>(Likely acting as WAF/Proxy for specific portals) |
| **Webflow (Fastly/AWS)** | `151.139.128.10` | `fr.webflow`<br>`en.fr`<br>(Marketing/Frontend landing pages) |

**Key Observation:** The infrastructure is segmented. The main marketing sites are hosted on **Webflow**, while the student applications (Intranet/Checker) are hosted on **AWS** EC2/Load Balancers.

## 3. Technologies and Frameworks
Based on subdomain naming conventions (`rails-assets`, `webflow`) and server responses, the following technology stack is in use:

### Web Frameworks & CMS
* **Ruby on Rails:**
    * Evidence: `rails-assets.holbertonschool.com`, `staging-rails-assets-apply.holbertonschool.com`.
    * Usage: Likely used for the "Apply" portal and older Intranet versions (`v1`, `v2`).
* **Webflow:**
    * Evidence: `webflow.holbertonschool.com`, `fr.webflow...`
    * Usage: Public-facing marketing website and regional landing pages.
* **Discourse:**
    * Evidence: `lvl2-discourse-staging.holbertonschool.com`
    * Usage: Community forum software.

### Infrastructure & Services
* **AWS CloudFront / S3:**
    * Evidence: `assets.holbertonschool.com` resolves to AWS IPs, likely serving static content via S3 buckets.
* **Zendesk:**
    * Evidence: `help.holbertonschool.com` and `support` subdomains often map to Zendesk's architecture.
* **Docker/Containers:**
    * Evidence: Naming conventions like `staging-apply`, `alpha`, and `v3` suggest a containerized deployment pipeline (Dev -> Staging -> Prod) typical of modern CI/CD flows.

## 4. Security Observations
* **Cloudflare Protection:** Subdomains like `support` are proxied behind Cloudflare, masking the origin IP and providing DDoS protection.
* **Environment Exposure:** Several staging environments (`staging-apply`, `alpha`, `beta`) are publicly resolvable. If these lack proper authentication, they could serve as attack vectors.
