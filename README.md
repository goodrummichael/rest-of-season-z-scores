# rest-of-season-z-scores
Calculate Rest of Season MLB Z-scores using Fangraphs Depth Charts projections

This R script generates rest of season projected 5x5 Z-scores using Fangraphs Depth Charts rest of season projections

Input: Fangraphs ROS Depth Charts projections

Output: Two files in your R working directory: batterROS.csv and pitcherROS.csv

Step 0: Download Fangraphs ROS depth charts projections CSV files

Batters are available here: https://www.fangraphs.com/projections.aspx?pos=all&stats=bat&type=rfangraphsdc&team=0&lg=all&players=0

Pitchers are available here: https://www.fangraphs.com/projections.aspx?pos=all&stats=pit&type=rfangraphsdc&team=0&lg=all&players=0

Step 0.5: Import the CSV files into R, and rename them batter and pitcher, respectively

Step 1: Execute the code. The resulting CSV files will be created in your R working directory
