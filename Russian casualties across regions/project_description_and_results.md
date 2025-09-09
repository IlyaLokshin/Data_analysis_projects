# Russian casualties across regions in the Russia-Ukraine war

## Project overview
The aim of this project is to model the casualties rate (per 100 000 men) in Russia-Ukraine war across regions of Russia based on various socio-economic and demographic indicators. 

It is important to note that this project is primarily focused on machine learning and does not intend to make any claims beyond the technical aspects of applying machine learning techniques to data on Russian casualties. This project does not pursue any political agenda. With this in mind, it may be interesting to explore how effectively machine learning techniques can model this type of data. 

## Main findings

Our best model generalized quite well: in the nested cross-validation tests on the train set, Pearson's correlation coefficient for the true and predicted values of the target variable is equal to 0.81, whereas $R^2$ is equal to 0.58. On the test set, Pearson's correlation coefficient is 0.78 and $R^2$ is 0.6. Our model is particularly misguided in regard to Sakha, seriously overestimating casualty rate there: without Sakha, Pearson's correlation coefficient would be more than 0.83 on the test set. 

Overall, the results can be considered meaningful, and it is possible to extract some tentative conclusions from the analysis. 

### Lesson 1. The intertwinement of the political and socio-economic logics within Russian recruitment policies

Perhaps the most general takeaway is that the patterns of casualties across Russian regions are indeed complex; they likely result from intricate intersections and interactions of various factors. 

Our analysis bolsters the hypothesis that both political and socio-economic logics are involved. To simplify the conceptual structure of  discussion, I associated political factors with coercive mobilization component of the Russian recruitment policy, whereas socio-economic factors might be especially pronounced for the other recruitment channel - volunteer conscription with substantive material incentives. The population density and the share of ethnically Russian population variables purport to reflect some elements of the political logic, whereas crime rates and the share of men with higher education aim to caprure relevant socio-economic characteristics. Crime rates, howerver, might be relevant for some peculiar practices of coercive mobilization as well, namely "direct" mobilization from prisons. There is some evidence that prisoners from ethnic minorities are particularly vulnerable to this form of coercive mobilization. ([[1]](https://www.rferl.org/a/russia-war-ukraine-inmates-concsripts-ethnic-minorities-coersion-rights-romanova/33492747.html)).

### Lesson 2. The intertwinement of general and local, contextual factors

The analysis also supports the conjecture that purely contextual factors might be important, which is clear from the significance of the dummy variable for Caucasian republics. Perhaps certain traits of Caucasian societies, such as their tight-knit social networks, could make Caucasian men less responsive to the individual incentives to participate in war; perhaps recent political history makes Russian government oversensitive to public sentiment in the Caucasus region, and this affects the political logic of rectuitment efforts in this region; perhaps Caucasian society (once again, thanks to tight social networks) is especially capable of resistance against mobilization efforts (protests in Dagestan were perhaps the most significant in the active phase of coercive mobilization). The precise reasons remain unclear, but our model indicates that Caucasian republics do not fully align with general patterns observed elsewhere.     

### Lesson 3. Economic conditions as such do not explain recruitment rates patterns

Interestingly, the most obvious economic variables, such as poverty level or (adjusted) average salary, have not exhibited sufficient explanatory power to be included in our final model. This is noteworthy because it is natural to regard these factors as the primary drivers within the socio-economic logic of recruitment. Indeed, there has been some debates as to whether such factors are able to account for observed patterns ([[2]](https://ore.exeter.ac.uk/repository/handle/10871/133317), [[3]](https://russiapost.info/society/targeting_ethnic_minorities)). Our model suggests a potential resolution to this issue: what may be particularly relevant in terms of socio-economic characteristics are not the economic conditions themselves but their intersection with social parameters (perhaps the presence of sufficiently developed networks of social support) and susceptibility to the state propaganda. The probable importance of social parameters is hinted at by our "Caucasus" feature (an economically disadvantaged region, albeit with relatively strong elements of traditional society) and crime rates, whereas the significance of the share of men with higher education supports the second proposition. 

### Lesson 4. Regions with a substantial share of ethnic minorities appear to be disproportionally affected

One of the most concerning and politically sensitive findings from the analysis is linked to the ethnic composition of regional populations. Our model indicates that regions with a higher percentage of ethnic minorities tend to experience higher casualty rates. 

A very important caveat is that the preceding analysis did not take into account the actual ethnicity of soldiers but was conducted on the regional level. This distinction may be significant, because there is research suggesting that ethnicity as such is not an explanatory factor of casualty rates in this war ([[4]](https://ore.exeter.ac.uk/repository/handle/10871/133317)). However, there is also plenty of evidence to the contrary ([[5]](https://brill.com/view/journals/inas/25/1/article-p126_11.xml#FN000009), [[6]](https://www.themoscowtimes.com/2022/09/27/ethnic-minorities-hit-hardest-by-russias-mobilization-activists-say-a78879)). 

In any case, it would be more reasonable to adopt a cautious interpretation of our findings, framing them in terms of regions with a substantial share of ethnic minorities rather than in terms of ethnic groups as such. Still, even this formulation raises questions about the underlying reasons for the observed patterns (assuming our model is reliable in this respect). As discussed earlier, these patterns may reflect some form of "imperial" logic influencing Russian recruitment policy. 

Another suggested explanation points to the presence of large military bases in near-border regions with high levels of ethnic minorities ([[7]](https://brill.com/view/journals/inas/25/1/article-p126_11.xml#FN000009)). However, if consider the sheer number of military bases across regions [[8]](https://en.wikipedia.org/wiki/List_of_Russian_military_bases), there does not appear to be a strong correlation with casualty rates. For instance, there are many bases in Moscow Oblast and Leningrad Oblast, both of which have low casualty rates; there are bases in other regions with low casualty rates, such as Chechnya, Amur Oblast, Nizhny Novgorod Oblast, etc. At the very least, the presence of military bases has to be combined with some other factors to serve as a reasonable explanatory variable; but, once again, the share of ethnic minorities in the regional population is the best candidate for such a factor.

***

Overall, when considering both political and socio-economic factors, it appears that the Russia-Ukraine war disproportionately affects the more vulnerable social strata — groups with fewer resources and types of capital (economic, social, symbolic). These groups ultimately become another victim of the war. If this observation is accurate, it highlights an  easily overlooked aspect of the tragic nature of this war.
