# Spec

Guardian API Docs: http://open-platform.theguardian.com/documentation/

Guardian API Key: 

## Actors

- Guardian
- Server
- Client

## Use Cases

### 1. Client opens the Homepage

**Description:** The Client asks to the Server to fetch the latest guardian Articles. So the Server requests to the Guardian to give him the latest 10 Articles, where it returns the title, the trailing text, the headline and the link of the article. The Server responds to the client delivering a list of Articles, containing the title, the headline or trailing text and the link to the single Article.

### 2\. Client opens single Article

**Description:** The Client asks to the Server to fetch a certain Article. So the Server requests to the Guardian to give him that Article, where it returns the title, the headline and the body to the article.

### 3\. Client opens a Section
