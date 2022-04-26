####### R script for calculating the correct 95th percentile of depth from the angsd output
####### run in shell: Rscript depth_doct.R file.depthSample
####### Note you MUST edit the genome size variable below

# read in data as vector
depth_data <- scan(commandArgs(trailingOnly=TRUE))

# user input genome size [edit as appropriate!!!!!!]
g_size <- 2218192823

# work out correct number of positions with zero reads
# This is genome size - sum of positions with mapped reads
zero_pos <- g_size - sum(depth_data[2:length(depth_data)])

# add correct number of positions with zero reads to the vector
depth_data[1] <- zero_pos

# calculate cumulative depth
cum_depth <- cumsum(depth_data)

# subtract 95% of genome size
cum_95perc <- cum_depth - (g_size * 0.95)

# create logic vector to identify when values become positive
lv <- cum_95perc > 0

# collect threshold value
tval <- min(which(lv == TRUE))

# minus 2 to convert to integer value below the 95% of read depth
depth_95th <- tval - 2

# Print to terminal
cat("The integer read number below the 95th percentile of depth is: ", depth_95th, "\n")

# make nice plots
name <- (commandArgs(trailingOnly=TRUE)[1])

pdf("plots.pdf", width=10, height=5)
par(mfrow=c(1,2))

# plot depth distribution
plot(c(0:(length(depth_data) - 1)), depth_data, 
	type="l", col="red", lwd=2,
	main="Mapped read depth distribution",
	xlab="read depth",
	ylab="frequency"
)
abline(v=depth_95th, lty=2)

# plot cumulative depth distribution
plot(c(0:(length(depth_data) - 1)), cum_depth,
	type="l", col="blue", lwd=2,
	main="Cumulative mapped read depth distribution",
	xlab="read depth",
	ylab="frequency"
)
abline(v=depth_95th, lty=2)

invisible(dev.off())

