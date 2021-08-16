# plot1.R
# load data
library(tidyverse)
library(lubridate)

# read data
power_consumption <- read_delim('data/household_power_consumption.txt', delim = ';', skip = 0)

# change date format
power_consumption <- power_consumption |>
    mutate(Date = as_date(Date, format='%d/%m/%Y'))

# filter data
power_consumption <- power_consumption |>
    filter(month(Date) == 2 &
           day(Date) %in% c(1, 2) &
           year(Date) == 2007)

# setting Global active power to numeric data type
power_consumption <- power_consumption |>
    mutate(Global_active_power = as.numeric(Global_active_power))

# plot histogram on ggplot
# power_consumption |>
#     ggplot() +
#     geom_histogram(aes(x=Global_active_power),
#                    binwidth = 0.5,
#                    boundary=0.5,
#                    fill='red',
#                    color='black') +
#     xlab('Global Active Power (kilowatts)') +
#     ylab('Frequency') +
#     ggtitle('Global Active Power') +
#     theme_classic() +
#     theme(plot.title = element_text(hjust = 0.5))
# ggsave('plot1.png', width=480, height=480, units = 'px')


png("plot1.png", width=480, height=480)
## Plot 1
hist(power_consumption$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
