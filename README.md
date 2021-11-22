## **Domain of Interest: Twitch Gaming** 

**Why are you interested in this field/domain?**  <br>
We like playing video games. <br>  <br>
**What other examples of data-driven projects have you found related to this domain (share at least 3)? And summarize them.** <br>
https://towardsdatascience.com/insights-from-visualizing-public-data-on-twitch-a73304a1b3eb <br>
This is a visualization of the size and the relationship between the different streamer communities. The size of the node is based on the number of views they get, and the thickness of the line increases which indicates the number of viewers that are overlapped between the streamer. The color of the node shows the type of community they are in. <br>
https://blog.twitch.tv/en/2015/02/04/visual-mapping-of-twitch-and-our-communities-cause-science-2f5ad212c3da/ 
<br>
This article visualizes the different game communities on Twitch and the biggest streamers in those communities. It also analyzes the strength of the connections within one community (eg. League of Legends streamers can be grouped by region like Asia and South America, while the Dota streamers appear to be one large blob).
<br>
https://visualsbyimpulse.com/countries-most-twitch-viewers-top-15/ <br>
The third article that we analyzed and are using to show connection of our datasets to our chosen domain is focused on the countries with the most twitch viewers. More specifically, this article shows the top 15 countries in the world wherein Twitch is a popular streaming platform for video games. This article was guided by data that was taken from Amazon’s own internal data. <br>  <br>
**What data-driven questions do you hope to answer about this domain (share at least 3)?**  <br>
What do people like to play on Twitch?<br>
What Twitch emotes are popular? <br>
Who is the top streamer on twitch from last year?<br>
 

## **Finding Data**
### **Dataset 1:**
**Where did you download the data (e.g., a web URL)?**
https://www.kaggle.com/aayushmishra1512/twitchdata
**How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
A Kaggle.com user by the name of Aayush Mishra got his data from the website known as sullygnome.com. The data is essentially about the top 1000 streamers on twitch over the past year. 
**How many observations (rows) are in your data?** 
1000
**How many features (columns) are in the data?**
11
**What questions (from above) can be answered using the data in this dataset?**
“Who is the top streamer on twitch from last year?”


### **Dataset 2:**
**Where did you download the data (e.g., a web URL)?**
https://www.kaggle.com/mowglii/twitch-chat-test-data
**How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
Kaggle user mowgli collected the data from the Twitch API using the R package Rchamp. (https://github.com/mowgl-i/Rchamp). This is a log of chat messages from the channel HealthyGamer_GG including the user, channel, message, and time. 
**How many observations (rows) are in your data?**
There are 7730 rows.
**How many features (columns) are in the data?**
There are 4 columns.
**What questions (from above) can be answered using the data in this dataset?**  
“What Twitch emotes are popular?”

### **Dataset 3:**
**Where did you download the data (e.g., a web URL)?**
https://www.kaggle.com/rankirsh/evolution-of-top-games-on-twitch 

**How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
The user used sullygnome.com, which is a twitch analytics and statistics site, to gather their data.
**How many observations (rows) are in your data?**
1738
**How many features (columns) are in the data?**
20
**What questions (from above) can be answered using the data in this dataset?**
What do people like to play on Twitch?
