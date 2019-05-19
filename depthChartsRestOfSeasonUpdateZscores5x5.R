#This code generates rest of season projected 5x5 Z-scores using Fangraphs Depth Charts rest of season projections
#Input: Fangraphs ROS Depth Charts projections
#Output: Two files in your R working directory: batterROS.csv and pitcherROS.csv

#Step 0:Download Fangraphs ROS depth charts projections CSV files
#Batters available here: https://www.fangraphs.com/projections.aspx?pos=all&stats=bat&type=rfangraphsdc&team=0&lg=all&players=0
#Pitchers available here: https://www.fangraphs.com/projections.aspx?pos=all&stats=pit&type=rfangraphsdc&team=0&lg=all&players=0

#Step 0.5: Import the CSV files, and rename them batter and pitcher, respectively

#Step 1: Execute the code below. The resulting CSV files will be created in your R working directory

#dedupe input files, just in case there are duplicate playerids
pitcher <- pitcher[order(pitcher$Team, -pitcher$IP),]
batter <- batter[order(batter$Team, -batter$PA),]

prest = pitcher[!duplicated(pitcher$playerid), ]
brest = batter[!duplicated(batter$playerid), ]

#Calculate scores for 5x5 batting statistics

#translate batting average to a counting stat based on ABs
brest$AVGnum <- (brest$AVG * brest$AB)
brest$AVGnum <- round(brest$AVGnum, digits = 0)

#subtract MLB league average batting average to mute the impact of compilers with mediocre batting averages
#hardcoded values based on overall Depth Charts projections as of 2019-05-19
brest$xAVG <- brest$AVGnum - round((brest$AB * .254), digits = 0)

#compute batting Z scores
brest$zAVG <- scale(brest$xAVG)
brest$zR <- scale(brest$R)
brest$zHR <- scale(brest$HR)
brest$zSB <- scale(brest$SB)
brest$zRBI <- scale(brest$RBI)
brest$zTotal <- brest$zAVG + brest$zR + brest$zHR + brest$zSB + brest$zRBI 

#Calculate scores for 5x5 pitching statistics

#calculate ERA counting stat (multiply by -1 since lower is better)
#subtract league average ERA to mute the impact of compilers with mediocre ERAs
#hardcoded values based on overall Depth Charts projections as of 2019-05-19
prest$xERA <- (prest$ER*9 - (prest$IP * 4.26)) * -1

#calculate WHIP counting stat (multiply by -1 since lower is better)
#subtract league average WHIP to mute the impact of compilers with mediocre rates
#hardcoded values based on overall Depth Charts projections as of 2019-05-19
prest$xWHIP <- ((prest$H + prest$BB) - (prest$IP * 1.34)) * -1

#compute pitching Z scores
prest$zERA <- scale(prest$xERA)
prest$zWHIP <- scale(prest$xWHIP)
prest$zW <- scale(prest$W)
prest$zSO <- scale(prest$SO)
prest$zSV <- scale(prest$SV)
prest$zTotal <- prest$zERA + prest$zWHIP + prest$zW + prest$zSO + prest$zSV 

#sort output files by total z score, descending IP/AB
prest <- prest[order(-prest$zTotal, -prest$IP),]
brest <- brest[order(-brest$zTotal, -brest$AB),]

#write CSVs
write.csv(brest, "batterROS.csv", row.names = FALSE)
write.csv(prest, "pitcherROS.csv", row.names = FALSE)