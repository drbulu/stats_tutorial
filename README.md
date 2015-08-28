# stats_tutorial  

## Overview  
This app was designed to help me remember concepts that I learnt while taking courses in the <a href="https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage">Data Science</a> specialisation on Coursera. The ability to interact with the concepts that I learn is quite valuable, and doing the 
<a href="https://www.coursera.org/course/devdataprod">Developing Data Products</a> has given me the opportunity to review concepts that I have previously learnt in another course called <a href="https://www.coursera.org/course/regmods">Regression Models</a>.  

The course is presently live at: 
<a href="https://drbulu.shinyapps.io/stats_tutorial">https://drbulu.shinyapps.io/stats_tutorial</a>. 

Please feel free to have a play with it to get a feel for to concepts presented.  

## Things to add  
1. Residual plots: I didn't have time to add them by assignment submission time. These could add some decent value as a compact way for users to assess the quality of the model that they generate through interacting with the data. I am not sure how to make these plots interactive... still figuring that out. I may have to make my own plots from the residual data in order to be able to do so. The basic idea is to be able to indicate to the user which points are in some way distort the model fit, thus exerting undue leverage or influence on the model. Naturally, I would need to then add the requisite documentation to be able to guide users through it.   

2. Add the option of additional data sets. I was toying with the idea of allowing the user to select a different data set to work on, as each new dataset would have a different structure, and thus pose a different challenge to interact with. This would introduce users to the fact that different datasets. This would also make it more interesting through enhanced variety. Randomly generated data sets like the noisy "projectData" that I created are nice, but Including data sets with more descriptive axes than simply "x" and "y" would be more beneficial and would bring the concepts closer to situations that users would encounter. Naturally, each new dataset would require a decent preamble. Simply changing the seed during data selection would be an easy way to start.   

3. Allowing users to select different types of models. Basically, include datasets that are not appropriately handled by the "default" simple linear regression approach presently used. This would force users to do some exploration... this would probably be the most challenging update.

4. Refactor the code! Now that I understand a bit better how the "Reactive" approach to Shiny apps works, I can streamline the code so that I can make one reference to a single "instance" of the user created data subset and the resulting user model. This would have the benefit of avoiding excessive computation (recreating objects unecessarily) as well as improving readability (code clarity and compactness).  

## References  
Some useful links that I encountered during the preparation of this app:  

The "Regression Models" and "Data Products" lecture material for the core concepts and tools with which to build this app.  

http://shiny.rstudio.com/articles/tag-glossary.html  
http://stackoverflow.com/questions/15403903/create-tables-with-conditional-formattiang-with-rmarkdown-knitr  
http://stackoverflow.com/questions/22408144/r-shiny-plot-with-dynamical-size   
