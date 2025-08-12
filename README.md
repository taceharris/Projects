# **Tace Harris**  

Welcome to my GitHub portfolio! I'm Tace Harris, a Political Science major with a minor in Quantitative Methods in the Social Sciences at The University of Michigan. My work focuses on the intersection of public policy and data analysis, and I have a deep intrest in health related issues. I have experience in research, statistical analysis, and working with big data.

## About Me

**Education**
- **Bachelor of Arts**, University of Michigan – Political Science & QMSS Minor (Expected May 2026)  
- **Associate of Arts**, Harrisburg Area Community College – Social Sciences  

**Technical Skills**
- **Languages:** Python, R, SQL  
- **Libraries:** pandas, NumPy, matplotlib, seaborn, scikit-learn, statsmodels  
- **Tools:** Tableau, SPSS, Git, Jupyter Notebook  
- **Methods:** Logistic regression, predictive modeling, data visualization, geospatial analysis, research design


## **Projects**  
**These projects were created as part of my minor coursework and have been modified for this portfolio**
### 1. Diabetes Risk Predictive Model  
[View the Report](./Report1.pdf)  | [View  Python Notebook](./Diabetes_Risk_Predictive_Model.ipynb)

**Summary:** Built a multivariate logistic regression model in Python using CDC diabetes health indicators to predict diabetes risk based on age, BMI, and physical activity.  
**Key Results:**  
- Achieved **86% accuracy** in the unweighted model, highly effective for identifying non-diabetic individuals.  
- Applied class weighting to improve recall for diabetic cases from **0.03 to 0.76**, trading overall accuracy for sensitivity.  
**Tools:** Python, pandas, scikit-learn, statsmodels, matplotlib
####Key Visualizations

##### Unweighted and Weighted Confusion Matrixes
<img width="350" height="360" alt="download" src="https://github.com/user-attachments/assets/578f505c-9d93-4222-96ae-bfd0e0a8b26e" />
<img width="325" height="330" alt="download (1)" src="https://github.com/user-attachments/assets/5dc215f4-fff6-4448-a00f-67d329ca3d4b" />

## 2.Geospatial Analysis of Crime, Neighborhoods, and Schools in Chicago  
[View the Report](./Geospatial_Data_Project.pdf) | [View the R Code](./Project1.R)

**Summary:**  
Conducted a geospatial analysis of crime distribution across Chicago with a focus on identifying high-risk areas near schools. Used city-provided crime, school location, zip code, and community area data to map risk patterns and assess property crime proximity to schools.

**Key Methods & Tools:**  
- **Tools:** R, RStudio, `sf` package, `ggplot2`  
- **Data Sources:** City of Chicago crime data & school location datasets  
- Created shapefiles for mapping, categorized crime rates by zip code and community area  
- Applied buffer zones (0.5 and 1 mile) to assess property crime incidents near schools  
- Generated thematic maps and bar charts ranking schools by nearby property crime incidents

**Key Findings:**  
- **Crime Concentration:** High-risk zip codes cluster in central Chicago, while community-level mapping shows pockets of high crime in the north-central and south-central areas.  
- **School Risk Zones:** Northwest Chicago has a dense cluster of schools with high property crime within 0.5 miles; Bouchet School had the highest within 1 mile, Ombudsman-Northwest High School the lowest.  
- **Disparities in Crime:** Crime distribution is highly uneven — the highest-crime community experiences **46x more incidents** than the lowest, and the highest-crime zip code sees **151x more incidents** than the lowest.  
- **Measurement Differences:** Some areas appear low-risk by community boundaries but high-risk by zip code, highlighting the importance of scale in crime analysis.

## 3. Sentiment and Predictive Analysis of Reddit Disability Discussions  
[View Full Report](./RedditScraping.pdf) | 

**Summary:**  
Analyzed over 2,000 Reddit comments from the r/AskReddit thread *“People with disabilities, what is something that’s normal for others but a nightmare for you?”* to explore how people with disabilities describe their daily experiences. Applied sentiment analysis, feature engineering, and predictive modeling to uncover emotional patterns, recurring themes, and classification accuracy.

**Key Methods & Tools:**  
- **Tools:** Python, PRAW, VADER, TextBlob, Flair, Scikit-learn, pandas, matplotlib, wordcloud  
- **Data Collection:** Scraped 2,063 comments with Python Reddit API Wrapper (PRAW), extracted text, upvotes, and timestamps, and engineered features for word/character counts  
- **Sentiment Analysis:** Classified comments as positive, negative, or neutral using VADER; compared results to TextBlob and Flair for accuracy and alignment  
- **Predictive Modeling:** Built a Random Forest Classifier to predict positive vs. negative sentiment using upvotes and sentiment score features

**Key Findings:**  
- **Balanced Sentiment:** Dataset contained 898 negative, 886 positive, and 331 neutral comments, reflecting a diverse range of emotional expression.  
- **Thematic Insights:** Negative comments often featured terms like “pain” and “can’t,” while positive comments included “help,” “thank,” and “hope.”  
- **Engagement Patterns:** Neutral comments received the highest average upvotes, suggesting Reddit users value nuanced or balanced responses.  
- **Model Performance:** Random Forest Classifier achieved **98.6% accuracy** with high precision and recall for both sentiment classes.  
- **Tool Comparison:** TextBlob moderately aligned with VADER (72% accuracy), while Flair showed bias toward negative classifications (63% accuracy), reinforcing VADER’s suitability for short, informal social media text.

**Impact & Applications:**  
Demonstrates the value of combining sentiment analysis with predictive modeling to interpret large-scale online discussions. Findings can inform accessibility advocacy, public perception studies, and computational social science research.



## Contact
- **LinkedIn:** [https://www.linkedin.com/in/tace-harris/]
- **Email:** tace@umich.edu
  
