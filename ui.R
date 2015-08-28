# data products course projects - UI 

# not sure about implementation of a "reset" button for the UI components for
# users to reset the system to the original defaults!

library(shiny)

checkboxNames1 = c(1:20)
checkbox2start = checkboxNames1[length(checkboxNames1)] + 1
checkboxNames2 = c(checkbox2start:40)

shinyUI(pageWithSidebar(
  
  headerPanel("Simple linear regression: Interactive model selection"),
  
  sidebarPanel(
    p(style="text-decoration: underline; font-weight:bold; color:blue;",
      "Select/Deselect Data values:"),
    
    fluidRow(
      column(5, checkboxGroupInput("checkbox1", NULL, checkboxNames1, checkboxNames1)
      ),
      column(5, checkboxGroupInput("checkbox2", NULL, checkboxNames2, checkboxNames2)
      ) 
    )
    
  ),
  
  mainPanel(
    tabsetPanel(selected = "README",
                tabPanel("1. Visualisation", 
                         div(align="center", plotOutput('multiDataGraph'))
                ),
                tabPanel("2. Basic stats", 
                         p(' '),
                         div(align="center",  
                             style = "font-size:150%; color:green", 
                             tableOutput('modelSummaryTable')
                         )
                ),
                tabPanel("3. Summary stats (User)", 
                         div(align="center",  style = "font-size:85%; color:black", 
                             dataTableOutput('userInfluenceSummaryTable')
                         )
                ),
                tabPanel("4. Summary stats (Reference)", 
                         br(),
                         div(align="center",  style = "font-size:85%; color:blue", 
                             dataTableOutput('refInfluenceSummaryTable')
                         )
                ),
                tabPanel("README", 
                         h2('Guide Outline'),
                         tags$ol(
                           tags$li(tags$a(href="#appOverview", "Overview")),
                           tags$li(tags$a(href="#appStructure", "Basic app structure")),
                           tags$li(tags$a(href="#walkthrough", "Simple Walkthrough")),
                           tags$li(tags$a(href="#glossary", "Glossary")),
                           tags$li(tags$a(href="#refinfo", "References"))                         
                         ),
                         
                         h2(id="appOverview",'Overview'),
                         
                         p('This app is an introductory tutorial into regression modelling
                         explores how a linear model is affected by the data that it 
                         describes. This app will also introduce users to some of the    
                         tools (statistical approaches) that can be used to measure the
                         quality and usefulness of a regression model. '),
                         HTML('<p>Humans make models of information all the time, often without
                         being conscious of it. In its simplest sense, a <b>model</b> is any way of 
                         viewing or representing the relationship between two or more pieces of
                         information (variables) about something of interest. Usually, one or variables
                         (called predictors) are used to predict the behaviour of another variable
                         (called the outcome). One of the simplest ways to think of the predictor and
                         outcome variables is as the x and y coordinates, respectively, of a cartesian 
                         graph or chart. Examples include:</p>'),
                         tags$ol(
                           tags$li('The weight (x) and height (y) of a child.'),
                           tags$li('The height of a parent (x) and the height of its child (y).'),
                           tags$li('The weight (x1), number of cylinders (x2) and fuel efficiency (y) of a car.')
                         ),
                         HTML('<p>
                         This tutorial app explores the characteristics of a 
                         <a href="https://en.wikipedia.org/wiki/Simple_linear_regression">simple linear model (SLM)</a>, 
                         but it is important to note that these concepts also apply to other types of linear models.
                         </p>'),
                         
                         h2("Basic app structure", id="appStructure"),
                         
                         p('This section describes the key components of this application.'),
                         h3('data'),
                         p('A simple set of 40 observations, each consisting of two measurements x and y.'),
                         h3('side panel'),
                         p('This contains a series of checkboxes that enable users to select or deselect 
                           observations. These selections represent the data used to create the "user model".'),
                         h3('visualisation tab'),
                         p('A simple pair of scatter plots that allow the user to see in real time how their
                           selections change the data to create the "user" data set compared to the "reference" 
                           dataset (has all observations).'),
                         h3('basic statistics tab'),
                         HTML('<p>Allows the user to interactively compare the R<sup>2</sup>,
                              gradient and y-intercept of both the "user" and "reference" models
                              to see how the user\'s data selection choices affect the resulting 
                              model compared to the reference model scenario. Please see the 
                              <a href="#glossary">glossary</a> for more detail.</p>'),                         
                         h3('Summary stats tab'),
                         HTML('<p>There are two summary statistics tabs, one for the "User" model
                              and one for the "Reference" model. These characteristics provide a
                              more in depth analysis of each model to enable the user to fine tune
                              the model that they create. Basically, these tables give the user an 
                              idea of which observations to add to or remove from their model. The
                              table characteristics are described in  more detail in 
                              the <a href="#glossary">glossary</a>.</p>'),

                         h2('Simple Walkthrough', id="walkthrough"),
                         p('This section is a quick guide to how to use the app to give you the 
                           best possile experience. Check out the steps below:'),
                         tags$ol(
                           tags$li('Step 1: Visualisation tab'),
                           p('Look at the data to get a feel for how the data is being displayed 
                             as well as for the distribution of the observations.'),
                           tags$li('Step 2: Side panel'),
                           p('a) add or remove observations using the side panel. Each checkbox 
                             represents an observation.'),
                           p('b) Checkout the "visualiation" tab to see the effect of the change.'),
                           tags$li('Step 3: Check the stats'),
                           p('Once you are happy with the changes that you have made, take a look at 
                             the "Basic stats" and "Summary stats" tabs to examine the characteristics 
                             of the "User" model that you create compared to the "Reference" model, 
                             which  contains all of the observations.'),
                           HTML('<p>Please checkout the <a href="#glossary">glossary</a> section if you need
                                the meanings of the characteristics.'),
                           tags$li('Step 4: Refine your model'),
                           HTML('<p>Repeat steps <b>2</b> and <b>3</b> until you get that 
                                <a href="https://en.wikipedia.org/wiki/Epiphany_%28feeling%29">"epiphany"</a> 
                                and understand for yourself how data composition (the observations that you 
                                choose to include) affects how it is modelled (the representation of the 
                                relationships between all the observations).'),
                           tags$li('Step 5: Share!'),
                           p('If you find this app to be helpful and/or entertaining, please share 
                             it with your friends and family!')
                         ),
                         
                         p(style="color:green;font-weight:bold;font-size:120%; font-family:Comic Sans MS, cursive, sans-serif",
                           'Thank you for trying out this app, I hope that you enjoyed it!'),
                         
                         h2('Glossary', id='glossary'),
                         
                         HTML('<table id = "glossTable">
                              <tr><th>Statistic</th><th>Description</th></tr>
                              <tr><td>gradient</td><td>The expected change in the response (y-axis) for every 1 unit change in the predictor (x-axis).</td></tr>
                              <tr><td>r-squared</td><td>The proportion (or percentage) of all of the variation in the data that is explained by a model that is used to represent it. Basically, this represents how well the model can use the x-axis component to predict the y-axis.</td></tr>
                              <tr><td>intercept</td><td>The value of the response (y-axis) when the predictor (x-axis) is zero. In least squares regression, this turns out to be the average of y-axis values.</td></tr>
                              <tr><td>sample</td><td>This corresponds to each of the observations in the dataset.</td></tr>
                              <tr><td>resid.ord</td><td>These are the ordinary residuals. Residuals represent the difference between the observed and predicted values of an observation. Typically, residuals represent the outcome (y-axis) component, since this is the characteristic of an observation that one is trying to predict.</td></tr>
                              <tr><td>resid.std</td><td>These are the standardized residuals (residuals divided by their standard deviations)</tr>
                              <tr><td>resid.t</td><td>standardized residuals where the ith data point was deleted in the calculation of the standard deviation for the residual to follow a t distribution.</td></tr>
                              <tr><td>press.resid</td><td>These are the PRESS residuals, i.e. the leave one out cross validation residuals, which are the difference in the response and the predicted response at data point i, where it was not included in the model fitting.</td></tr>
                              <tr><td>hat.values</td><td>measure leverage. For more see <a href="https://en.wikipedia.org/wiki/Leverage_(statistics)">this</a>.</td></tr>
                              <tr><td>c.dist</td><td>cooks.distance - overall change in the coefficients when the ith point is deleted</td></tr>
                              <tr><td>df.fits</td><td>change in the predicted response when the ith point is deleted in fitting the model.</td></tr>
                              </table>'),
                         br(),
                         HTML('<p>Feel free to consult <a href="https://en.wikipedia.org/">wikipedia</a> for more clarity.</p>'),
                         
                         h2('References', id='refinfo'),
                         
                         HTML('<p>
                                  This app was inspired by concepts learned in the <a href="https://www.coursera.org/course/regmods">Regression Models</a> and 
                                  <a href="https://www.coursera.org/course/devdataprod">Developing Data Products</a> 
                                  classes at Coursera.
                                  These are the 7<sup>th</sup> and 9<sup>th</sup> parts in the <a href="https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage">Data Science</a> 
                                  specialisation (series of courses).
                              </p>'),
                         br(),
                         HTML('<p>
                                  This app was created using the 
                                  <a href="https://www.r-project.org/about.html">R programming language</a> using the 
                                  <a href="http://rstudio.com/">Rstudio</a> 
                                  <a href="https://en.wikipedia.org/wiki/Integrated_development_environment">IDE</a> with the 
                                  <a href="http://shiny.rstudio.com/">Shiny</a> web application framework.
                              </p>'),
                         br(),
                         HTML('<style>
                              #glossTable td {
                              border-width: 1px;
                              padding: 1px;
                              border-style: inset;
                              border-color: gray;
                              background-color: white;}
                              </style>')
                )
    )
  )
)) # end of shinyUI()!

## you could in a later version, include residual plots :)

# useful
# http://shiny.rstudio.com/articles/tag-glossary.html

# tabPanel("Readme", 
#          div(
#            p(style="color:purple; font-weight:bold;text-align:center;",
#              'This section would contain the introduciton if kept \n
#                    Inspiration: 07_RegressionModels/02_04_residuals_variation_diagnostics')
#          )
# ),
