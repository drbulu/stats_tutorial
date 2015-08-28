# data products course projects - UI 

#### Imports
library(shiny)
library(knitr) # to load the table formatting function kable().
# pander library might be useful :)
# http://stackoverflow.com/questions/15403903/create-tables-with-conditional-formatting-with-rmarkdown-knitr

# how to find outliers in a list of values? e.g. which hatvalue(s) are outstanding
# from the group

# test data to plot - would be interesting to mess with simulated data also
# set.seed(125)
set.seed(2055)
# create input data frame with x and y variables, then make it noisy
# by randomly modifying add 5 randomly selected points
projectData = as.data.frame(cbind(x = c(1:40), 
                                  y = c(1:40) + rnorm(40, mean=1, sd=4) 
                                  + rnorm(40, mean=1, sd=2) ))

randomCols = floor(abs(rnorm(5, mean=1, sd=20)))
randomFactor = floor(abs(rnorm(5, mean=0.7, sd=12)))
for(item in 1:length(randomCols)){
  projectData[item,2] <- projectData[item,2] + randomFactor[item]
}

refdataModel = lm(y ~ x, data=projectData)

shinyServer( function(input, output) {
  # 1. Graphical output - scatter plots
  
  # 0) create list from user selected data points!
  userSelectList  <- reactive({              
    c(input$checkbox1,  input$checkbox2)
  })
  userSelectList
  # A) Model constructed based on user input to checkboxes
  createDataSubset  <- reactive({ projectData[ userSelectList() ,] })
  
  # http://stackoverflow.com/questions/22408144/r-shiny-plot-with-dynamical-size
  # B) combined plot
  plotHeight = 400
  output$multiDataGraph <- renderPlot({
    configTest = function(type="a"){
      par(mai = c(0.4,0.4,0.2,0.4))
      ifelse(type=="a", par(mfrow=c(2,1)), par(mfrow=c(1,2)))
    }
    configTest(type="a")
        
    outputData = createDataSubset() # Should move this so that it is only called once!
    outputDataModel = lm(y ~ x, data=outputData)
    # old plot
    plot(outputData$x, outputData$y, 
         main = "User model",
         xlab = "data points (x)", 
         ylab = "data values (y)",
         pch = 5, cex = 2.5,
         col = "purple")
    abline(a = outputDataModel, col="red")
    text(outputData$x, outputData$y, labels=row.names(outputData))
    # reference plot
    plot(projectData$x, projectData$y, 
         main = "Reference model",
         xlab = "data points (x)", 
         ylab = "data values (y)",
         col = ifelse(projectData$x %in% userSelectList(), "blue", "red"))
    abline(a = refdataModel)
  }, width=500, height=plotHeight)
  
  # 2. Tabular output
    
  # helper function to extract the required summary statistics from the linear models
  extractBasicStats <- function(model){
    roundVal = 3
    names = c("r-squared", "gradient", "intercept")
    values = c(round(summary(model)$r.squared, roundVal), 
               round(model$coefficients[2], roundVal),
               round(model$coefficients[1], roundVal)            
               )
    names(values) <- names
    return (values)
  }

  extractResids <- function(model){
    o = c()
    roundVal = 2
    # types of residuals
    o$resid.ord <- round(resid(model),roundVal)
    o$resid.std <- round(rstandard(model),roundVal)
    o$resid.t <- round(rstudent(model),roundVal)
    o$press.resid <- resid(model) / (1 - hatvalues(model))
    # conveniently converts the vector of vectors via cbind() type operation :)
    return( as.data.frame(o) )
  }

  # work out how to keep original row names for ease of interpretation
  extractInfluenceVals <- function(model){
    o = c()
    roundVal = 2
    # other influence measures
    o$hat.values <- round(hatvalues(model),roundVal)
    o$c.dist <- cooks.distance(model)
    o$df.fits <- dffits(model)
    return( as.data.frame(o) )
  }

  output$modelSummaryTable <- renderTable({
    # create regression model from user input choices
    userOutputData = createDataSubset()
    userOutputModel = lm(y ~ x, userOutputData)
    # create output data frame from user and reference data key statistics 
    reference = extractBasicStats(refdataModel)
    user = extractBasicStats(userOutputModel)  
    # preparing output for display
    outputData = rbind(user, reference)
    return(outputData)
  }, include.rownames = TRUE)
  
  # there is a lot of repetitive code... oh well, fix later
  output$userInfluenceSummaryTable <- renderDataTable({
    # initialise user data subset
    userData = createDataSubset()
    # regression model
    userModel = lm(y ~ x, userData)
    # extract residuals from datasets
    residuals = extractResids(userModel)
    influence = extractInfluenceVals(userModel)
    # preparing output for display
    sample = as.numeric(row.names(userData)) # possibly too simplistic... works :)
    outputData = as.data.frame(cbind(sample,residuals, influence))
    return(round(outputData,3))
  })

output$refInfluenceSummaryTable <- renderDataTable({
  # regression model
  refModel = lm(y ~ x, projectData)
  # extract residuals from datasets
  residuals = extractResids(refModel)
  influence = extractInfluenceVals(refModel)
  # preparing output for display
  sample = as.numeric(row.names(projectData))
  outputData = as.data.frame(cbind(sample, residuals, influence))
  return(round(outputData,3))
})

# # there is a lot of repetitive code... oh well, fix later


  
})

# bad approach.. data not really comparable (different # rows expected)
#   output$influenceSummaryTable <- renderDataTable({
#     # initialise user data subset
#     userData = createDataSubset()
#     # regression models
#     userModel = lm(y ~ x, userData)
#     refModel = lm(y ~ x, projectData)
#     # extract residuals from datasets
#     reference = extractInfluenceVals(refModel)
#     user = extractInfluenceVals(userModel)
#     # give unique names to output
#     names(reference) <- paste("ref", names(reference), sep=".")
#     names(user) <- paste("user", names(user), sep=".")
#     # preparing output for display
#     outputData = as.data.frame(cbind(user, reference))
#     return(round(outputData,3))
#   })