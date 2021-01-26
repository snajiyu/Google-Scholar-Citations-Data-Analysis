# Title: clean-data-script
# Description : This script is for web scraping two datasets obtained from google scholar citations. 
# The html input is wrangled and and the data is cleaned and saved as a delimited csv file.
# Input(s): html pages
# Output(s): datasets csv
# Author: Najiyullah Sanee
# Date: 12/04/2019

library(xml2)
library(rvest)
library(stringr)
library(V8)
 


 
scholar_page1 <- read_html("https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2019/master/data/scholar/richard_thaler_GoogleScholarCitations.html")
 

 
scholar_page2 <- read_html("https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2019/master/data/scholar/william_nordhaus_GoogleScholarCitations.html")
 



## Extracting information for Scholar 1
sholar_name1 <- scholar_page1 %>%
  html_node("#gsc_prf_in") %>% 
  html_text()

sholar_inst1 <- scholar_page1 %>% 
  html_node("#gsc_prf_in+ .gsc_prf_il") %>% 
  html_text()
 
scholar_papers1 <- scholar_page1 %>%
  html_nodes(".gsc_a_at") %>%
  html_text()
 
papers1_authors <- scholar_page1 %>% 
  html_nodes(".gsc_a_at+ .gs_gray") %>%
  html_text()
 
papers1_jour <- scholar_page1 %>% 
  html_nodes(".gs_gray+ .gs_gray") %>%
  html_text()
 
papers1_citat <- scholar_page1 %>% 
  html_nodes(".gsc_a_ac") %>% 
  html_text()
 
papers1_year <- scholar_page1 %>%
  html_nodes(".gsc_a_hc") %>%
  html_text()
 


## Extracting Information for Scholar 2
scholar_name2 <- scholar_page2 %>% 
  html_node("#gsc_prf_in") %>% 
  html_text()
 
scholar_inst2 <- scholar_page2 %>%
  html_node(".gsc_prf_il") %>%
  html_text()
 
scholar_papers2 <- scholar_page2 %>%
  html_nodes(".gsc_a_at") %>% 
  html_text()
 
papers2_authors <- scholar_page2 %>% 
  html_nodes(".gsc_a_at+ .gs_gray") %>% 
  html_text()
 
papers2_jour <- scholar_page2 %>% 
  html_nodes(".gs_gray+ .gs_gray") %>%
  html_text()
 
papers2_citat <- scholar_page2 %>%
  html_nodes(".gsc_a_ac") %>%
  html_text()
 
papers2_year <- scholar_page2 %>% 
  html_nodes(".gsc_a_hc") %>%
  html_text()
 

 
## Dataframe for scholar 1
scholar1_dataset <- data.frame(paperName = scholar_papers1, 
                               researcher = papers1_authors, 
                               journal = papers1_jour, 
                               citations = papers1_citat, 
                               year = papers1_year)
 



 
#Dataframe for Scholar 2
scholar2_dataset <- data.frame(paperName = scholar_papers2,
                               researcher = papers2_authors,
                               journal = papers2_jour,
                               citations = papers2_citat,
                               year = papers2_year)
 



write.csv(scholar1_dataset, 'data/cleandata/scholar1_dataset.csv', fileEncoding = "UTF-8")
 
write.csv(scholar2_dataset,'data/cleandata/scholar2_dataset.csv', fileEncoding = "UTF-8")
 




